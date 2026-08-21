using Godot;
using System;

[GlobalClass]
public partial class CE_SpawnUnit : CardEffect
{
    [Export] private PackedScene _unitToSpawn;
    [Export] private int _numberOfUnit = 1;
    
    public override void Action(GodotObject areaOfControl)
    {
        //Trés temp
        if (areaOfControl is Node3D area3D)
        {
            if (_unitToSpawn.Instantiate() is Node3D unit)
            {
                area3D.GetTree().Root.AddChild(unit);
                unit.GlobalPosition = area3D.GlobalPosition;
            }
        }
    }
}
