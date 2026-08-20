using Godot;
using System;
using System.Collections.Generic;

[GlobalClass]
public partial class GameManager : Node
{
	private static GameManager _Instance;

	private List<Manager> _managers;
	
	public override void _Ready()
	{
		if (_Instance == null)
		{
			_Instance = this;
			InitManagers();
		}
		else
		{
			Free();
		}
	}

	public static T GetManager<T>() where T : Manager
	{
		foreach (var manager in _Instance._managers)
		{
			if (manager.GetType() == typeof(T))
			{
				return manager as T;
			}
		}
		return default;
	}
	
	private void InitManagers()
	{
		_managers = new List<Manager>();
		var children = GetChildren(true);
		foreach (var child in children)
		{
			var childType = child.GetType();
			if (childType.IsSubclassOf(typeof(Manager)))
			{
				_managers.Add(child as Manager);
			}
		}
	}
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
