Class {
	#name : #PlayerHistoryTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerHistoryTests >> testAPlayerStoryCanHaveACollectionOfPlayerPosition [
	| playerStory |
	playerStory := PlayerStory player: 'hector'.
	playerStory updatePlayerTo: 5 withLaps: 1.
	playerStory updatePlayerTo: 5 withLaps: 1.
	self
		assert: playerStory player equals: 'hector';
		assert: playerStory lastPlayerPosition position equals: 5
]
