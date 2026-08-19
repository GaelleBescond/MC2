using Godot;
using System;

[GlobalClass]
public partial class CE_SpawnUnit : CardEffect
{
    [Export] private PackedScene _unitToSpawn;
    [Export] private int _numberOfUnit = 1;
    
    public override void Action(GodotObject areaOfControl)
    {
        GD.Print($"Bravo tu as spawn {_numberOfUnit}{_unitToSpawn.GetName()} sur {areaOfControl.Get("name")}");
    }
}
