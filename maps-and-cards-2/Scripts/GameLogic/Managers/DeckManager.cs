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
	}

	public override void _Process(double delta)
	{
	}

	public CardResource GetTopCard(bool remove = true)
	{
		if (_currentDeck.Count > 0)
		{
			var ret = _currentDeck[0].Duplicate() as CardResource; // Je suis que moyen sur de ça
			if (remove)
			{
				_currentDeck.RemoveAt(0);
			}

			GD.Print(_currentDeck.Count);
			GD.Print(ret);
			return ret;
		}
		else
		{
			EmptyDeck();
		}
		return default;
	}

	private void EmptyDeck()
	{
		GD.Print("Ono le deck est vide");
	}
}
