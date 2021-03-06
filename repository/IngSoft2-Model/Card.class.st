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


    Implementation Points
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Card >> affect: arg1 on: aBoard [
	^ self subclassResponsibility
]

{ #category : #asserting }
Card >> assertAffectedPlayerQuantity: arg1 on: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #asserting }
Card >> assertOwnerCanUseOnTurnOf: aPlayer [
	^ self subclassResponsibility
]

{ #category : #action }
Card >> cancel: otherCard on: aBoard [
	AssertionFailure signal: 'Only Cancellation Card can cancel other card'
]

{ #category : #initialization }
Card >> initialize [
	owner := OrderedCollection new
]

{ #category : #asserting }
Card >> isTransient [
	^ self subclassResponsibility
]

{ #category : #updating }
Card >> lastPlayedCards: aCardsCollection [
	
]

{ #category : #accessing }
Card >> owner [
	^ owner first.
]

{ #category : #updating }
Card >> updateOwner: aPlayer [
	owner addFirst: aPlayer.
]
