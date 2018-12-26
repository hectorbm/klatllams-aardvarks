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
	lastCard:		<Object>
	owner:		<Object>


    Implementation Points
"
Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'lastCard',
		'lastCardIsSet'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #updating }
RedoCard >> addLastCard: aCard [
	lastCard := aCard.
	lastCardIsSet := true
]

{ #category : #adding }
RedoCard >> addOn: aBoard affecting: playersCollection [
	lastCard addOn: aBoard affecting: playersCollection
]

{ #category : #affecting }
RedoCard >> affect: aPlayer on: aBoard [
	lastCard affect: aPlayer on: aBoard.
	aBoard deck addToRemovedCards: self
]

{ #category : #asserting }
RedoCard >> assertOwnerCanUseAnytime [
]

{ #category : #affecting }
RedoCard >> cancel: otherCard on: aBoard [
	lastCard cancel: otherCard on: aBoard.
	aBoard deck addToRemovedCards: self
]

{ #category : #initialization }
RedoCard >> initializeOwnedBy: aPlayer [
	owner := aPlayer.
	lastCardIsSet := false
]

{ #category : #updating }
RedoCard >> lastPlayedCards: aCardsCollection [
	aCardsCollection notEmpty
		ifTrue: [ self addLastCard: aCardsCollection first ]
		ifFalse: [ AssertionFailure signal: 'Redo only can be used if a Card was Used' ]
]
