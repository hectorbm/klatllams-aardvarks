"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".
For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	player:		<Object>
	playerPositions:		<Object>


    Implementation Points
"
Class {
	#name : #PlayerStory,
	#superclass : #Object,
	#instVars : [
		'playerPositions',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerStory class >> player: aPlayer [
	^self new initializeWithPlayer: aPlayer
]

{ #category : #initialization }
PlayerStory >> initializeWithPlayer: aPlayer [
	player := aPlayer.
	playerPositions := OrderedCollection new.
	
]

{ #category : #accessing }
PlayerStory >> lastPlayerPosition [
	^ playerPositions first
]

{ #category : #accessing }
PlayerStory >> player [
	^ player
]

{ #category : #updating }
PlayerStory >> updatePlayerTo: aPosition withLaps: aValue [
	| newPlayerPosition |
	newPlayerPosition := PlayerPosition player: player position: aPosition laps: aValue.
	playerPositions addFirst: newPlayerPosition
]
