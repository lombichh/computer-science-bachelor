#include <iostream>
#include <cstring>
using namespace std;

struct playlist {
    char title[30];
    int duration;
    int plays;
    int listeners;
    playlist *next;
};

void printPlaylist(playlist *pointer) {
    playlist *playlistIterator = pointer;
    while (playlistIterator != NULL) {
        cout << playlistIterator -> title << endl;
        playlistIterator = playlistIterator -> next;
    }
}

playlist* more3Playlist(playlist *pointer) {
    playlist *playlistIterator = pointer;

    playlist *newPointer;
    playlist *newPlaylistIterator = newPointer;

    while (playlistIterator != NULL) {
        if (playlistIterator -> duration >= 180) {
            newPlaylistIterator -> next = playlistIterator;
            newPlaylistIterator = newPlaylistIterator -> next;
        }
        playlistIterator = playlistIterator -> next;
    }

    return newPointer -> next;
}

double totalDuration(playlist *pointer) {
    playlist *playlistIterator = pointer;

    double totalDur = 0;
    while (playlistIterator != NULL) {
        totalDur += playlistIterator -> duration;
        playlistIterator = playlistIterator -> next;
    }

    return totalDur / 180;
}

void mostPlayedSong(playlist *pointer, char mostPlayedTitle[]) {
    playlist *playlistIterator = pointer;

    int mostPlayedPlays = 0;

    while (playlistIterator != NULL) {
        if (playlistIterator -> plays > mostPlayedPlays) {
            mostPlayedPlays = playlistIterator -> plays;
            strcpy(mostPlayedTitle, playlistIterator -> title);
        }
        playlistIterator = playlistIterator -> next;
    }
}

int main() {
    playlist *pointer;

    playlist firstSong = {"Song 1", 180, 1000, 400};
    playlist secondSong = {"Song 2", 179, 10000, 5600};
    playlist thirdSong = {"Song 3", 200, 5000, 1000};
    playlist fourthSong = {"Song 4", 100, 100, 20};

    firstSong.next = &secondSong;
    secondSong.next = &thirdSong;
    thirdSong.next = &fourthSong;
    fourthSong.next = NULL;

    pointer = &firstSong;

    printPlaylist(pointer);

    cout << totalDuration(pointer) << " minutes" << endl;
    char mostPlayedTitle[30];
    mostPlayedSong(pointer, mostPlayedTitle);
    cout << "Most played song: " << mostPlayedTitle;

    return 0;
}