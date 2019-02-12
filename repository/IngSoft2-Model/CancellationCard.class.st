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
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> affect: card on: aBoard [
	self cancel: card on: aBoard
]

{ #category : #asserting }
CancellationCard >> assertAffectedPlayerQuantity: playersCollection on: aBoard [
]

{ #category : #asserting }
CancellationCard >> assertOwnerCanUseOnTurnOf: aPlayer [
	
]

{ #category : #action }
CancellationCard >> cancel: otherCard on: aBoard [
	aBoard deck activeCardsPlayerAffected isEmpty
		ifTrue: [ owner first addCard: self.
			AssertionFailure signal: 'Cannot play Cancellation when not active cards available' ].
	aBoard deck removeAnActive: otherCard
]

{ #category : #asserting }
CancellationCard >> isTransient [
	^ true
]
