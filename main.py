# Client Setup, restrict scope to the YouTube
CLIENT_SECRETS_FILE = "client_secret.json"
SCOPES = ['https://www.googleapis.com/auth/youtube.force-ssl']
API_SERVICE_NAME = 'youtube'
API_VERSION = 'v3'

import google.oauth2.credentials
import os
import pickle
import csv

from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# Build a service to interact with the API and cache the credentials
def get_authenticated_service():
    credentials = None
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            credentials = pickle.load(token)
    # check if credentials are invalid or do not exist
    if not credentials or not credentials.valid:
        # check if the credentials have expired
        if credentials and credentials.expired and credentials.refresh_token:
            credentials.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(CLIENT_SECRETS_FILE, SCOPES)
            credentials = flow.run_console()
        
        # save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(credentials, token)
    
    return build(API_SERVICE_NAME, API_VERSION, credentials= credentials)

# Navigate multiple pages of search results:
# fetches the first page that has results that correspond to the keyword.
# Then it keeps fetching results as long as there are results to be fetched
# and the max pages has not been reached.
def get_videos(service, **kwargs):
    final_results = []
    results = service.search().list(**kwargs).execute()

    i = 0
    max_pages = 3
    while results and i < max_pages:
        final_results.extend(results['items'])

        # check if another page exists
        if 'nextPageToken' in results:
            kwargs['pageToken'] = results['nextPageToken']
            results = service.search().list(**kwargs).execute()
            i += 1
        else:
            break
    
    return final_results

# Get Video Comments
def get_video_comments(service, **kwargs):
    comments = []
    results = service.commentThreads().list(**kwargs).execute()

    while results:
        for item in results['items']:
            comment = item['snippet']['topLevelComment']['snippet']['textDisplay']
            comments.append(comment)
            print(comments)

        # continuously check if there is more data to be loaded and fetch it till there is none left.
        if 'nextPageToken' in results:
            kwargs['pageToken'] = results['nextPageToken']
            results = service.commentThreads().list(**kwargs).execute()
        else:
            break
    
    return comments

def write_to_csv(comments):
    with open('commentz.csv', 'w') as comments_file:
        comments_writer = csv.writer(comments_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        comments_writer.writerow(['Video ID', 'Title', 'Comment'])
        for row in comments:
            comments_writer.writerow(list(row))

# Search videos by Keyword
def search_videos_by_keyword(service, **kwargs):
    results = get_videos(service, **kwargs)
    final_result = []
    for item in results:
        # print('%s - %s' % (item['snippet']['title'], item['id']['videoId']))
        title = item['snippet']['title']
        video_id = item['id']['videoId']
        comments = get_video_comments(service, part='snippet', videoId=video_id, textFormat='plainText')
        final_result.extend([(video_id, title, comment) for comment in comments])

        print(final_result)
        write_to_csv(final_result)

# get comment thread of a video
def get_comment_threads(youtube, video_id, comments):
    threads = []
    results = youtube.commentThreads().list(
        part="snippet",
        videoId=video_id,
        textFormat="plainText",
    ).execute()

    # Get the first set of comments
    for item in results["items"]:
        threads.append(item)
        comment = item["snippet"]["topLevelComment"]
        text = comment["snippet"]["textDisplay"]
        comments.append(text)
        print(text)
        # output_file.write(text + "\n")


    # Keep getting comments from the following pages
    while ("nextPageToken" in results):
        results = youtube.commentThreads().list(
            part="snippet",
            videoId=video_id,
            pageToken=results["nextPageToken"],
            textFormat="plainText",
        ).execute()
        for item in results["items"]:
            threads.append(item)
            comment = item["snippet"]["topLevelComment"]
            text = comment["snippet"]["textDisplay"]
            comments.append(text)
            print(text)
            # output_file.write(text + "\n")


    print("Total threads: %d" % len(threads))

    return threads

# get replies from the comment threads
def get_comments(youtube, parent_id, comments):
    results = youtube.comments().list(
        part="snippet",
        parentId=parent_id,
        textFormat="plainText"
    ).execute()

    for item in results["items"]:
        text = item["snippet"]["textDisplay"]
        comments.append(text)
        print(text)
        # output_file.write(text + "\n")

    
    return results["items"]

# Main script
if __name__ == '__main__':
    # When running locally, disable OAuthlib's HTTPs verification.
    # When running in production DO NOT leave this option enabled.
    # os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'
    youtube = get_authenticated_service()
    # videoID = 'exsOim0Lyl4'
    videoID = '_F8ruFXcqck'

    # # keyword = input('Enter a keyword: ')
    # # search_videos_by_keyword(service, q=keyword, part='id,snippet', eventType='completed', type='video')
    
    # final_result = []

    # comments = get_video_comments(service, part='snippet', videoId='exsOim0Lyl4', textFormat='plainText')
    # # title = item['snippet']['title']
    # # video_id = item['id']['videoId']

    # final_result.extend([(comment) for comment in comments])
    # write_to_csv(final_result)

    # args = argparser.parse_args()
    # youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION, developerKey=DEVELOPER_KEY)

    try:
        # output_file = open("output.txt", "a")
        comments = []
        video_comment_threads = get_comment_threads(youtube, videoID, comments)

        for thread in video_comment_threads:
            get_comments(youtube, thread["id"], comments)

        print("Total comments: %d \n" % len(comments))
        print(comments)

        # for comment in comments:
            # output_file.write(comment.encode("utf-8") + "\n")
            # output_file.write(comment + "\n")

        # output_file.close()

    except HttpError as e:
        print("An HTTP error %d occurred:\n%s" % (e.resp.status, e.content))

