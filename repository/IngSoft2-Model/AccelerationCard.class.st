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
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
AccelerationCard >> addOn: aBoard affecting: playersCollection [
	self assertAffectedPlayerQuantity: playersCollection on: aBoard.
	aBoard
		addAnActive: (CardPlayerAffected withCard: self affecting: playersCollection)
]

{ #category : #affecting }
AccelerationCard >> affect: aPlayer on: aBoard [
	aBoard move: aPlayer by: 1
]

{ #category : #asserting }
AccelerationCard >> assertAffectedPlayerQuantity: playersCollection on: aBoard [
	aBoard gameStatus players ~= playersCollection 
		ifTrue: [ AssertionFailure signal: 'Acceleration card must affect all the players' ]
]

{ #category : #asserting }
AccelerationCard >> assertOwnerCanUseAnytime [
	owner addCard: self.
	AssertionFailure signal: 'This is a permanent card'
]
