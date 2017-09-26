
--[[---------------------------------------------------------
	Name: gamemode:StartChat( teamsay )
	Desc: Start Chat.

			If you want to display your chat shit different here's what you'd do:
			In StartChat show your text box and return true to hide the default
			Update the text in your box with the text passed to ChatTextChanged
			Close and clear your text box when FinishChat is called.
			Return true in ChatText to not show the default chat text

-----------------------------------------------------------]]
function GM:StartChat( teamsay )

	return false

end

--[[---------------------------------------------------------
	Name: gamemode:FinishChat()
-----------------------------------------------------------]]
function GM:FinishChat()
end

--[[---------------------------------------------------------
	Name: gamemode:ChatTextChanged( text)
-----------------------------------------------------------]]
function GM:ChatTextChanged( text )
end

--[[---------------------------------------------------------
	Name: ChatText
	Allows override of the chat text
-----------------------------------------------------------]]
function GM:ChatText( playerindex, playername, text, filter )

	if ( filter == "chat" ) then
		Msg( playername, ": ", text, "\n" )
	else
		Msg( text, "\n" )
	end

	return false

end

--[[---------------------------------------------------------
	Name: gamemode:OnPlayerChat()
		Process the player's chat.. return true for no default
-----------------------------------------------------------]]
function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )

	--
	-- I've made this all look more complicated than it is. Here's the easy version
	--
	-- chat.AddText( player, Color( 255, 255, 255 ), ": ", strText )
	--

	local tab = {}

	if ( bPlayerIsDead ) then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "*DEAD* " )
	end

	if ( bTeamOnly ) then
		table.insert( tab, Color( 30, 160, 40 ) )
		table.insert( tab, "(TEAM) " )
	end

	if ( IsValid( player ) ) then
		table.insert( tab, player )
	else
		table.insert( tab, "Console" )
	end

	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": " .. strText )

	chat.AddText( unpack(tab) )

	return true

end

--[[---------------------------------------------------------
	Name: gamemode:OnChatTab( str )
	Desc: Tab is pressed when typing (Auto-complete names, IRC style)
-----------------------------------------------------------]]
function GM:OnChatTab( str )

	str = string.TrimRight(str)
	
	local LastWord
	for word in string.gmatch( str, "[^ ]+" ) do
		LastWord = word
	end

	if ( LastWord == nil ) then return str end

	for k, v in pairs( player.GetAll() ) do

		local nickname = v:Nick()

		if ( string.len( LastWord ) < string.len( nickname ) && string.find( string.lower( nickname ), string.lower( LastWord ), 0, true ) == 1 ) then

			str = string.sub( str, 1, ( string.len( LastWord ) * -1 ) - 1 )
			str = str .. nickname
			return str

		end

	end

	return str

end