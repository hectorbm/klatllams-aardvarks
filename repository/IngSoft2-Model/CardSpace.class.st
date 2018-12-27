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
	cards:		<Object>


    Implementation Points
"
Class {
	#name : #CardSpace,
	#superclass : #Space,
	#instVars : [
		'cards'
	],
	#classInstVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardSpace >> affect: aPlayer on: aBoard [
	| aCard |
	self assertCanExtractFromDeckOf: aBoard.
	aCard := aBoard deck deliverNewCard.
	aCard updateOwner: aPlayer.
	aPlayer addCard: aCard
]

{ #category : #asserting }
CardSpace >> assertCanExtractFromDeckOf: aBoard [
	aBoard deck removedCards isEmpty
		ifTrue: [ AssertionFailure
				signal: 'You must wait until there is at least 1 removed card' ]
]
