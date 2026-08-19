using Godot;
using System;

[GlobalClass]
public partial class CardResource : Resource
{
    [Export] private string _cardName, _cardDesc;
    [Export] private int _cardCost;
    [Export] private CardEffect _effect;

    public string CardName => _cardName;

    public string CardDesc => _cardDesc;

    public int CardCost => _cardCost;


    public void PlayCard(GodotObject areaOfControl)
    {
        _effect.Action(areaOfControl);
    }
}
