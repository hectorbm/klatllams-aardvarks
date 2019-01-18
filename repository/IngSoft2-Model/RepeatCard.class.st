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
	notUsedCard:		<Object>
	owner:		<Object>


    Implementation Points
"
Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
RepeatCard >> addOn: aBoard affecting: aPlayersCollection [
	self assertAffectedPlayerQuantity: aPlayersCollection on: aBoard.
	
]

{ #category : #affecting }
RepeatCard >> affect: aPlayersCollection on: aBoard [
	| aPosition |
	aPosition := aBoard lastLandingPositionOf: aPlayersCollection first.
	aPosition ~= 0
		ifTrue: [ (aBoard spaces at: aPosition) affect: aPlayersCollection first on: aBoard ].
	
]

{ #category : #asserting }
RepeatCard >> assertAffectedPlayerQuantity: aPlayersCollection on: aBoard [
	aPlayersCollection size ~= 1
		ifTrue: [ AssertionFailure signal: 'This card can only affect one player' ]
]

{ #category : #asserting }
RepeatCard >> assertOwnerCanUseAnytime [
]
