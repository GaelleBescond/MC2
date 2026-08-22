using Godot;
using System;
using Godot.Collections;

public partial class DeckManager : Manager
{
	//Stored as Array export for now for debug 
	[Export] private Array<CardResource> _currentDeck, _fullDeck, _discard;
	
	public override void _Ready()
	{
		_currentDeck = _fullDeck.Duplicate();
		_discard = new Array<CardResource>();
	}

	public override void _Process(double delta)
	{
	}

	public void Discard(CardResource card)
	{
		_discard.Add(card);
	}
	
	public CardResource GetTopCard(bool remove = true)
	{
		while (_currentDeck.Count <= 0)
		{
			ShuffleDiscard();
		}
		var ret = _currentDeck[0]; // Je suis que moyen sur de ça maybe duplcate as CardRessources
		if (remove)
		{
			_currentDeck.RemoveAt(0);
		}
		return ret;
	}

	private void ShuffleDiscard()
	{
		_currentDeck = _discard.Duplicate();
		ShuffleDeck();
		_discard.Clear();
	}

	private void ShuffleDeck()
	{
		_currentDeck.Shuffle();
	}
}
