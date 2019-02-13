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
		'lastCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #updating }
RedoCard >> addLastCard: aCard [
	lastCard addFirst: aCard.
	
]

{ #category : #action }
RedoCard >> addTo: aBoard [
	| players |
	players := aBoard gameStatus players.
	aBoard deck addAnActive: (CardPlayerAffected withCard: self affecting: players)
]

{ #category : #action }
RedoCard >> addTo: aBoard affecting: player [
	lastCard first isTransient
		ifTrue: [ lastCard first affect: player on: aBoard.
			aBoard deck addToRemovedCards: self ]
		ifFalse: [ aBoard deck addAnActive: (CardPlayerAffected withCard: self affecting: player asOrderedCollection) ]
]

{ #category : #action }
RedoCard >> affect: aPlayer on: aBoard [
	lastCard first affect: aPlayer on: aBoard.
]

{ #category : #asserting }
RedoCard >> assertAffectedPlayerQuantity: playersCollection on: aBoard [
	lastCard first assertAffectedPlayerQuantity: playersCollection on: aBoard
]

{ #category : #asserting }
RedoCard >> assertOwnerCanUseOnTurnOf: aPlayer [
	
]

{ #category : #action }
RedoCard >> cancel: otherCard on: aBoard [
	lastCard first cancel: otherCard on: aBoard.
	
]

{ #category : #initialization }
RedoCard >> initialize [
	super initialize.
	lastCard := OrderedCollection new.
]

{ #category : #asserting }
RedoCard >> isTransient [
	^ lastCard first isTransient
]

{ #category : #updating }
RedoCard >> lastPlayedCards: aCardsCollection [
	aCardsCollection notEmpty
		ifTrue: [ self addLastCard: aCardsCollection first ]
		ifFalse: [ AssertionFailure signal: 'Redo only can be used if a Card was Used' ]
]
