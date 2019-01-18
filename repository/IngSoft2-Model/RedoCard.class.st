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
	lastCard addFirst: aCard.
	lastCardIsSet := true.
]

{ #category : #adding }
RedoCard >> addOn: aBoard affecting: playersCollection [
	lastCard first assertAffectedPlayerQuantity: playersCollection on: aBoard
]

{ #category : #affecting }
RedoCard >> affect: aPlayer on: aBoard [
	lastCard first affect: aPlayer on: aBoard.
]

{ #category : #asserting }
RedoCard >> assertAffectedPlayerQuantity: playersCollection on: aBoard [
	lastCard first assertAffectedPlayerQuantity: playersCollection on: aBoard
]

{ #category : #asserting }
RedoCard >> assertOwnerCanUseAnytime [
	lastCardIsSet 
		ifTrue: [ lastCard first assertOwnerCanUseAnytime  ]
]

{ #category : #affecting }
RedoCard >> cancel: otherCard on: aBoard [
	lastCard first cancel: otherCard on: aBoard.
	aBoard deck addToRemovedCards: self
]

{ #category : #initialization }
RedoCard >> initialize [
	super initialize.
	lastCardIsSet := false.
	lastCard := OrderedCollection new.
]

{ #category : #updating }
RedoCard >> lastPlayedCards: aCardsCollection [
	aCardsCollection notEmpty
		ifTrue: [ self addLastCard: aCardsCollection first ]
		ifFalse: [ AssertionFailure signal: 'Redo only can be used if a Card was Used' ]
]

{ #category : #updating }
RedoCard >> removeOn: aBoard [
	aBoard deck addToRemovedCards: self.
	lastCardIsSet := false
]
