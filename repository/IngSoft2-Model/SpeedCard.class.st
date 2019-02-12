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
	owner:		<Object>


    Implementation Points
"
Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> addTo: aBoard affecting: player [
	aBoard deck addAnActive: (CardPlayerAffected withCard: self affecting: player asOrderedCollection )
]

{ #category : #action }
SpeedCard >> affect: aPlayer on: aBoard [
	aBoard calculateAndUpdate: aPlayer by: 1
]

{ #category : #asserting }
SpeedCard >> assertAffectedPlayerQuantity: playersCollection on: aBoard [
	playersCollection size = 1
		ifTrue: [ aBoard gameStatus players
				detect: [ :player | player = playersCollection first ]
				ifNone: [ AssertionFailure signal: 'Invalid Player' ] ]
		ifFalse: [ AssertionFailure signal: 'This card only affects 1 player' ]
]

{ #category : #asserting }
SpeedCard >> assertOwnerCanUseOnTurnOf: aPlayer [
	self owner ~= aPlayer
		ifTrue: [ AssertionFailure signal: 'You cannot play now' ]
]

{ #category : #asserting }
SpeedCard >> isTransient [
	^ false
]
