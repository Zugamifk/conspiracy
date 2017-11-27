local path = "Spacegame/"
SpaceGame = Namespace{}

SpaceGame:AddNames{
        GameState = path.."gamestate",
        StarField = path.."starfield",
        Physics = path.."physics",
        Planet = path.."planet",
        Character = path.."character",
        Ship = path.."ship",
        Camera = path.."camera",

        CharacterControl = path.."controls/character",
        ShipControl = path.."controls/ship",
        FreeCameraControl = path.."controls/freecamera"
}
