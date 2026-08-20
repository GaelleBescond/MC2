using Godot;
using Godot.Collections;
using System;

[GlobalClass]
public partial class CardHandler : Node3D
{
	//Very rough stuffs
	private float TEMP_cardSize = .575f;
	private float TEMP_cardSpace = .003f;
	
	//Should add an editor card pool and stuff
	[Export] private Array<Node3D> _cardsInHand;
	[Export] private Array<Node3D> _drawnCards,_undrawnCards;
	[Export] private int _maxHandSize = 7, _startingHand = 3;

	private DeckManager _deckManager;
	
	public override void _Ready()
	{
		_deckManager = GameManager.GetManager<DeckManager>();
		_drawnCards = new Array<Node3D>();
		_undrawnCards = new Array<Node3D>();
		foreach (var card in _cardsInHand)
		{
			DisableCard(card);
		}

		for (int i = 0; i < _startingHand; i++)
		{
			DrawCard();
		}
		
	}
	private void ReorderCards()
	{
		for (int i = 0; i < _drawnCards.Count; i++)
		{
			var card = _drawnCards[i];
			card.Position = Vector3.Right *i* (TEMP_cardSize + TEMP_cardSpace);
		}
	}

	private void DisableCard(Node3D cardToDisable)
	{
		_drawnCards.Remove(cardToDisable);
		_undrawnCards.Add(cardToDisable);
		
		cardToDisable.SetVisible(false);
		cardToDisable.ProcessMode = ProcessModeEnum.Disabled;
		
		ReorderCards();
	}
	private void DrawCard()
	{
		AddCardToHand(_deckManager.GetTopCard(true));
	}
	
	private void AddCardToHand(CardResource newCard)
	{
		var addedCard = _undrawnCards[0];
		addedCard.SetVisible(true);		
		addedCard.ProcessMode = ProcessModeEnum.Inherit;
		addedCard.Call("_initialize", newCard, this);

		_undrawnCards.Remove(addedCard);
		_drawnCards.Add(addedCard);
		
		ReorderCards();
	}
}
