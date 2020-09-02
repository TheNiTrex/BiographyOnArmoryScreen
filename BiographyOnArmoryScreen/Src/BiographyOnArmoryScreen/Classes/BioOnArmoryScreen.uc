class BioOnArmoryScreen extends UIScreenListener;

event OnInit(UIScreen Screen) {

	local UIArmory_MainMenu armoryScreen;
	local UIPanel BioPanel;
	local UIBGBox BioBg;
	local UIX2PanelHeader BioHeader;
	local UITextContainerImproved BioTextContainer;
	local XComGameState_Unit Unit;

	if (UIArmory_MainMenu(Screen) == none)
			return;

	armoryScreen = UIArmory_MainMenu(Screen);

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(armoryScreen.UnitReference.ObjectID));

	BioPanel = armoryScreen.Spawn(class'UIPanel', Screen); 
	BioPanel.bAnimateOnInit = false;
	BioPanel.InitPanel('bioPanel'); 

	if (class'CHHelpers' != none) { //Checks if Highlander is loaded or not and adjusts the UI accordingly

		BioPanel.SetPosition(101.5, 727.5); //If Highlander is enabled

	} else {

		BioPanel.SetPosition(100, 750); //If Highlander is not enabled

	}

	BioBG = armoryScreen.Spawn(class'UIBGBox', BioPanel); 
	BioBG.LibID = class'UIUtilities_Controls'.const.MC_X2Background;
	
	if (class'CHHelpers' != none) { //Checks if Highlander is loaded or not and adjusts the UI accordingly

		BioBG.InitBG('BG', 0, 0, 425, 300); //If Highlander is enabled

	} else {

		BioBG.InitBG('BG', 0, 0, 410, 300); //If Highlander is not enabled

	}

	BioHeader = armoryscreen.Spawn(class'UIX2PanelHeader', BioPanel);
	BioHeader.InitPanelHeader('Header', class'UICustomize_Info'.default.m_strBiographyLabel);
	BioHeader.SetHeaderWidth(bioBG.Width - 20);
	BioHeader.SetPosition(bioBG.X + 10, bioBG.Y + 10);
	BioHeader.Show();

	BioTextContainer = armoryScreen.Spawn(class'UITextContainerImproved', BioPanel);
	BioTextContainer.InitTextContainer('BioTextContainer');
	BioTextContainer.bAutoScroll = true;
	BioTextContainer.SetPosition(BioHeader.X, BioBG.Y + BioBG.Height - 250);
	BioTextContainer.SetSize(BioHeader.headerWidth, BioBG.Height - 65);
	BioTextContainer.SetText(Unit.GetBackground());

}

Event OnReceiveFocus(UIScreen Screen) { //Triggers whenever the Armory Screen is cycled between Units

	local UIArmory_MainMenu armoryScreen;
	local UITextContainerImproved BioTextContainer;
	local XComGameState_Unit Unit;

	//`log("TEST - OnReceiveFocus");

	if (UIArmory_MainMenu(Screen) == none)
		return;

	armoryScreen = UIArmory_MainMenu(Screen);

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(armoryScreen.UnitReference.ObjectID));

	BioTextContainer = UITextContainerImproved(Screen.GetChild('BioTextContainer'));
	BioTextContainer.SetText(Unit.GetBackground());

}

Event OnLoseFocus(UIScreen Screen) {

	if (UIArmory_MainMenu(Screen) == none)
		return;

}