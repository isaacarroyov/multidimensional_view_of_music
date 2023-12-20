import pandas as pd
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

clientID = 'CLIENT ID'
clientSecret = 'CLIENT SECRET'

list_names = []
list_uris = []
list_acousticness = []
list_danceability = []
list_energy = []
list_loudness = []
list_valence = []
list_speechiness = []
list_duration_ms = []


client_credential_manager = SpotifyClientCredentials(client_id=clientID, client_secret=clientSecret)
sp = spotipy.Spotify(client_credentials_manager=client_credential_manager)

dict_harrys_house = sp.album_tracks('SPOTIFY ALBUM URI')
list_info_harrys_house_songs = dict_harrys_house['items']

# Get list of names of the songs and URI
for song in list_info_harrys_house_songs:
    list_names.append(song['name'])
    list_uris.append(song['uri'])

# Get audio features
list_audio_features = sp.audio_features(list_uris)

for audio_feature in list_audio_features:
    list_acousticness.append(audio_feature['acousticness'])
    list_danceability.append(audio_feature['danceability'])
    list_energy.append(audio_feature['energy'])
    list_loudness.append(audio_feature['loudness'])
    list_valence.append(audio_feature['valence'])
    list_speechiness.append(audio_feature['speechiness'])
    list_duration_ms.append(audio_feature['duration_ms'])

# Create a dataframe an save it as csv
df = pd.DataFrame(dict(
    song_name = list_names,
    uri = list_uris,
    acousticness = list_acousticness,
    danceability = list_danceability,
    energy = list_energy,
    loudness = list_loudness,
    valence = list_valence,
    speechiness = list_speechiness,
    duration_ms = list_duration_ms))

df['artist'] = 'ARTIST NAME'
df['album'] = "ALBUM NAME"

df.to_csv("path/to/save/file.csv", index= False)

print("Done")