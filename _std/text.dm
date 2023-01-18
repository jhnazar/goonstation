/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	return ""

/proc/trim_right(text)
	for (var/i = length(text) to 1 step -1)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)

	return ""

/proc/startswith(text, start)
	if(length(text) < length(start))
		return FALSE
	return copytext(text, 1, length(start) + 1) == start

/proc/endswith(text, end)
	if(length(text) < length(end))
		return FALSE
	return copytext(text, length(text) - length(end) + 1, length(text) + 1) == end

/proc/trim(text)
	return trim_reduced(text)

//Returns a string with reserved characters and spaces after the first and last letters removed
//Like trim(), but very slightly faster. worth it for niche usecases
/proc/trim_reduced(text)
	var/starting_coord = 1
	var/text_len = length(text)
	for (var/i in 1 to text_len)
		if (text2ascii(text, i) > 32)
			starting_coord = i
			break

	for (var/i = text_len, i >= starting_coord, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, starting_coord, i + 1)

	if(starting_coord > 1)
		return copytext(text, starting_coord)
	return ""

/proc/capitalize(t)
	. = t
	if(isatom(t))
		var/atom/A = t
		t = A.name
	. = copytext_char(t, 1, 2)
	return uppertext(.) + copytext_char(t, 2)

/// Returns true if the given string has a vowel
/proc/isVowel(var/t as text)
	return findtextEx(lowertext(t), "aeiouåäö") > 0

/**
  * Returns true if given string is just space characters
  * The explicitly defined entries are various blank unicode characters that don't get included as white space by \s
  */
var/global/regex/is_blank_string_regex = new(@{"^(\s|[\u00A0\u00AC\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u200B\u200C\u200D\u200E\u200F\u2011\u2028\u2029\u202A\u202B\u202C\u202D\u202E\u202F\u205F\u2060\u2066\u2067\u2068\u2069\u206A\u206B\u206C\u206D\u206E\u206F\u3000])*$"})
/proc/is_blank_string(var/txt)
	if (is_blank_string_regex.Find(txt))
		return 1
	return 0 //not blank

var/global/regex/discord_emoji_regex = new(@{"(?:<|&lt;)(?:a)?:([-a-zA-Z0-9_]+):(\d+)(?:>|&gt;)"}, "g")
/proc/discord_emojify(text)
	return discord_emoji_regex.Replace(text, {"<img src="https://cdn.discordapp.com/emojis/$2.gif" onerror="if (this.src != 'https://cdn.discordapp.com/emojis/$2.png') this.src = 'https://cdn.discordapp.com/emojis/$2.png';" title="$1" width="32" height="32">"})

/proc/linkify(text)
	. = text
	while(full_url_regex.Find(text))
		var/http_part = full_url_regex.group[1]
		if(length(http_part) == 0)
			http_part = "http://"
		var/full_url = http_part + full_url_regex.group[2]
		. = replacetext(., full_url_regex.match, "<a target='_blank' href='[full_url]'>[full_url_regex.match]</a>")

/// Generates a random Unicode emoji that will look ok in the chat
/proc/random_emoji()
	// filtered out list of emoji to those that look ok in the font we use
	return pick("‼","⁉","™","ℹ","↔","↕","↖","↗","↘","↙","↩","↪","⌚","⌛","⌨","⏏","⏩","⏪","⏫","⏬","⏭","⏮","⏯",
		"⏰","⏱","⏲","⏳","⏸","⏹","⏺","Ⓜ","▶","◀","☀","☁","☂","☃","☄","☎","☑","☔","☕","☘","☚","☛",
		"☜","☝","☞","☟","☠","☢","☣","☦","☪","☮","☯","☸","☹","☺","☿","♀","♁","♂","♈","♉","♊","♋","♌","♍","♎",
		"♏","♐","♑","♒","♓","♟","♠","♡","♢","♣","♤","♥","♦","♧","♨","♻","♾","♿","⚒","⚓","⚔","⚕","⚖","⚗","⚙",
		"⚛","⚜","⚠","⚡","⚢","⚣","⚤","⚥","⚦","⚧","⚨","⚩","⚪","⚫","⚰","⚱","⚽","⚾","⛄","⛅","⛈","⛎","⛏","⛑","⛓",
		"⛔","⛣","⛩","⛪","⛰","⛱","⛲","⛳","⛴","⛵","⛷","⛸","⛹","⛺","⛽","✂","✅","✈","✉","✊","✋","✌","✍","✎",
		"✏","✐","✒","✔","✖","✝","✡","✨","✳","✴","❄","❇","❌","❎","❓","❔","❕","❗","❣","❤","❥","➕","➖","➗","➡",
		"➰","➿","⤴","⤵","⤶","⤷","⬅","⬆","⬇","⬛","⬜","⭐","⭕","🀀","🀁","🀂","🀃","🀄","🀅","🀆","🀇","🀈","🀉","🀊",
		"🀋","🀌","🀍","🀎","🀏","🀐","🀑","🀒","🀓","🀔","🀕","🀖","🀗","🀘","🀙","🀚","🀛","🀜","🀝","🀞","🀟","🀠","🀡","🀢",
		"🀣","🀤","🀥","🀦","🀧","🀨","🀩","🀪","🀫","🃏","🅰","🅱","🅲","🅳","🅴","🅵","🅶","🅷","🅸","🅹","🅺","🅻","🅼","🅽","🅾",
		"🅿","🆀","🆁","🆂","🆃","🆄","🆅","🆆","🆇","🆈","🆉","🆊","🆋","🆌","🆍","🆎","🆏","🆐","🆑","🆒","🆓","🆔","🆕","🆖",
		"🆗","🆘","🆙","🆚","🌀","🌁","🌂","🌃","🌄","🌅","🌆","🌇","🌈","🌉","🌊","🌋","🌌","🌍","🌎","🌏","🌐","🌑",
		"🌒","🌓","🌔","🌕","🌖","🌗","🌘","🌙","🌚","🌛","🌜","🌝","🌞","🌟","🌠","🌡","🌤","🌥","🌦","🌧","🌨","🌩","🌪",
		"🌫","🌬","🌭","🌮","🌯","🌰","🌱","🌲","🌳","🌴","🌵","🌶","🌷","🌸","🌹","🌺","🌻","🌼","🌽","🌾","🌿","🍀","🍁",
		"🍂","🍃","🍄","🍅","🍆","🍇","🍈","🍉","🍊","🍋","🍌","🍍","🍎","🍏","🍐","🍑","🍒","🍓","🍔","🍕","🍖","🍗",
		"🍘","🍙","🍚","🍛","🍜","🍝","🍞","🍟","🍠","🍡","🍢","🍣","🍤","🍥","🍦","🍧","🍨","🍩","🍪","🍫","🍬","🍭",
		"🍮","🍯","🍰","🍱","🍲","🍳","🍴","🍵","🍶","🍷","🍸","🍹","🍺","🍻","🍼","🍽","🍾","🍿","🎀","🎁","🎂","🎃","🎄",
		"🎅","🎆","🎇","🎈","🎉","🎊","🎋","🎌","🎍","🎎","🎏","🎐","🎑","🎒","🎓","🎖","🎗","🎙","🎚","🎛","🎞","🎟","🎠",
		"🎡","🎢","🎣","🎤","🎥","🎦","🎧","🎨","🎩","🎪","🎫","🎬","🎭","🎮","🎯","🎰","🎱","🎲","🎳","🎴","🎵","🎶",
		"🎷","🎸","🎹","🎺","🎻","🎼","🎽","🎾","🎿","🏀","🏁","🏂","🏃","🏄","🏅","🏆","🏇","🏈","🏉","🏊","🏋","🏌",
		"🏍","🏎","🏏","🏐","🏑","🏒","🏓","🏔","🏕","🏖","🏗","🏘","🏙","🏚","🏛","🏜","🏝","🏞","🏟","🏠","🏡","🏢","🏣",
		"🏤","🏥","🏦","🏧","🏨","🏩","🏪","🏫","🏬","🏭","🏮","🏯","🏰","🏳","🏴","🏵","🏷","🏸","🏹","🏺","🏻","🏼","🏽",
		"🏾","🏿","🐀","🐁","🐂","🐃","🐄","🐅","🐆","🐇","🐈","🐉","🐊","🐋","🐌","🐍","🐎","🐏","🐐","🐑","🐒","🐓",
		"🐔","🐕","🐖","🐗","🐘","🐙","🐚","🐛","🐜","🐝","🐞","🐟","🐠","🐡","🐢","🐣","🐤","🐥","🐦","🐧","🐨","🐩",
		"🐪","🐫","🐬","🐭","🐮","🐯","🐰","🐱","🐲","🐳","🐴","🐵","🐶","🐷","🐸","🐹","🐺","🐻","🐼","🐽","🐾","🐿",
		"👀","👁","👂","👃","👄","👅","👆","👇","👈","👉","👊","👋","👌","👍","👎","👏","👐","👑","👒","👓","👔","👕",
		"👖","👗","👘","👙","👚","👛","👜","👝","👞","👟","👠","👡","👢","👣","👤","👥","👦","👧","👨","👩","👪","👫",
		"👬","👭","👮","👯","👰","👱","👲","👳","👴","👵","👶","👷","👸","👹","👺","👻","👼","👽","👾","👿","💀","💁",
		"💂","💃","💄","💅","💆","💇","💈","💉","💊","💋","💌","💍","💎","💏","💐","💑","💒","💓","💔","💕","💖","💗",
		"💘","💙","💚","💛","💜","💝","💞","💟","💠","💡","💢","💣","💤","💥","💦","💧","💨","💩","💪","💫","💬","💭",
		"💮","💯","💰","💱","💲","💳","💴","💵","💶","💷","💸","💹","💺","💻","💼","💽","💾","💿","📀","📁","📂","📃",
		"📄","📅","📆","📇","📈","📉","📊","📋","📌","📍","📎","📏","📐","📑","📒","📓","📔","📕","📖","📗","📘","📙","📚",
		"📛","📜","📝","📞","📟","📠","📡","📢","📣","📤","📥","📦","📧","📨","📩","📪","📫","📬","📭","📮","📯","📰",
		"📱","📲","📳","📴","📵","📶","📷","📸","📹","📺","📻","📼","📽","📿","🔀","🔁","🔂","🔃","🔄","🔅","🔆","🔇",
		"🔈","🔉","🔊","🔋","🔌","🔍","🔎","🔏","🔐","🔑","🔒","🔓","🔔","🔕","🔖","🔗","🔘","🔙","🔚","🔛","🔜","🔝",
		"🔞","🔟","🔠","🔡","🔢","🔣","🔤","🔥","🔦","🔧","🔨","🔩","🔪","🔫","🔬","🔭","🔮","🔯","🔰","🔱","🔲","🔳",
		"🔴","🔵","🔶","🔷","🔸","🔹","🔺","🔻","🔼","🔽","🕉","🕊","🕋","🕌","🕍","🕎","🕐","🕑","🕒","🕓","🕔","🕕",
		"🕖","🕗","🕘","🕙","🕚","🕛","🕜","🕝","🕞","🕟","🕠","🕡","🕢","🕣","🕤","🕥","🕦","🕧","🕯","🕰","🕳","🕴",
		"🕵","🕶","🕷","🕸","🕹","🕺","🖇","🖊","🖋","🖌","🖍","🖐","🖔","🖕","🖖","🖤","🖥","🖨","🖱","🖲","🖼","🗂","🗃","🗄",
		"🗑","🗒","🗓","🗜","🗝","🗞","🗡","🗣","🗨","🗯","🗳","🗺","🗻","🗼","🗽","🗾","🗿","😀","😁","😂","😃","😄","😅",
		"😆","😇","😈","😉","😊","😋","😌","😍","😎","😏","😐","😑","😒","😓","😔","😕","😖","😗","😘","😙","😚",
		"😛","😜","😝","😞","😟","😠","😡","😢","😣","😤","😥","😦","😧","😨","😩","😪","😫","😬","😭","😮","😯",
		"😰","😱","😲","😳","😴","😵","😶","😷","😸","😹","😺","😻","😼","😽","😾","😿","🙀","🙁","🙂","🙃","🙄",
		"🙅","🙆","🙇","🙈","🙉","🙊","🙋","🙌","🙍","🙎","🙏","🚀","🚁","🚂","🚃","🚄","🚅","🚆","🚇","🚈","🚉","🚊",
		"🚋","🚌","🚍","🚎","🚏","🚐","🚑","🚒","🚓","🚔","🚕","🚖","🚗","🚘","🚙","🚚","🚛","🚜","🚝","🚞","🚟","🚠",
		"🚡","🚢","🚣","🚤","🚥","🚦","🚧","🚨","🚩","🚪","🚫","🚬","🚭","🚮","🚯","🚰","🚱","🚲","🚳","🚴","🚵","🚶",
		"🚷","🚸","🚹","🚺","🚻","🚼","🚽","🚾","🚿","🛀","🛁","🛂","🛃","🛄","🛅","🛋","🛌","🛍","🛎","🛏","🛐","🛑",
		"🛒","🛕","🛠","🛡","🛢","🛣","🛤","🛥","🛩","🛫","🛬","🛰","🛳","🛴","🛵","🛶","🛷","🛸","🛹","🛺","🟠","🟡",
		"🟢","🟣","🟤","🟥","🟦","🟧","🟨","🟩","🟪","🟫","🤍","🤎","🤏","🤐","🤑","🤒","🤓","🤔","🤕","🤖","🤗",
		"🤘","🤙","🤚","🤛","🤜","🤝","🤞","🤟","🤠","🤡","🤢","🤣","🤤","🤥","🤦","🤧","🤨","🤩","🤪","🤫","🤬","🤭",
		"🤮","🤯","🤰","🤱","🤲","🤳","🤴","🤵","🤶","🤷","🤸","🤹","🤺","🤼","🤽","🤾","🤿","🥀","🥁","🥂","🥃","🥄",
		"🥅","🥇","🥈","🥉","🥊","🥋","🥌","🥍","🥎","🥏","🥐","🥑","🥒","🥓","🥔","🥕","🥖","🥗","🥘","🥙","🥚",
		"🥛","🥜","🥝","🥞","🥟","🥠","🥡","🥢","🥣","🥤","🥥","🥦","🥧","🥨","🥩","🥪","🥫","🥬","🥭","🥮","🥯",
		"🥰","🥱","🥳","🥴","🥵","🥶","🥺","🥻","🥼","🥽","🥾","🥿","🦀","🦁","🦂","🦃","🦄","🦅","🦆","🦇","🦈",
		"🦉","🦊","🦋","🦌","🦍","🦎","🦏","🦐","🦑","🦒","🦓","🦔","🦕","🦖","🦗","🦘","🦙","🦚","🦛","🦜","🦝",
		"🦞","🦟","🦠","🦡","🦢","🦥","🦦","🦧","🦨","🦩","🦪","🦮","🦯","🦰","🦱","🦲","🦳","🦴","🦵","🦶","🦷",
		"🦸","🦹","🦺","🦻","🦼","🦽","🦾","🦿","🧀","🧁","🧂","🧃","🧄","🧅","🧆","🧇","🧈","🧉","🧊","🧍","🧎","🧏",
		"🧐","🧑","🧒","🧓","🧔","🧕","🧖","🧗","🧘","🧙","🧚","🧛","🧜","🧝","🧞","🧟","🧠","🧡","🧢","🧣","🧤","🧥",
		"🧦","🧧","🧨","🧩","🧪","🧫","🧬","🧭","🧮","🧯","🧰","🧱","🧲","🧳","🧴","🧵","🧶","🧷","🧸","🧹","🧺","🧻",
		"🧼","🧽","🧾","🧿","🩰","🩱","🩲","🩳","🩸","🩹","🩺","🪀","🪁","🪂","🪐","🪑","🪒","🪓","🪔","🪕")
	// commented out full version (includes emoji that look ugly in the font we use), might be useful if we move to Twemoji or something
	/*
	// source for ranges: https://stackoverflow.com/questions/30470079/emoji-value-range
	return ascii2text(pick(
		1; 0x00A9,
		1; 0x00AE,
		1; 0x203C,
		1; 0x2049,
		1; 0x20E3,
		1; 0x2122,
		1; 0x2139,
		(0x2199 - 0x2194 + 1); rand(0x2194, 0x2199),
		(0x21AA - 0x21A9 + 1); rand(0x21A9, 0x21AA),
		1; 0x231A,
		1; 0x231B,
		1; 0x2328,
		1; 0x23CF,
		(0x23F3 - 0x23E9 + 1); rand(0x23E9, 0x23F3),
		(0x23FA - 0x23F8 + 1); rand(0x23F8, 0x23FA),
		1; 0x24C2,
		1; 0x25AA,
		1; 0x25AB,
		1; 0x25B6,
		1; 0x25C0,
		(0x25FE - 0x25FB + 1); rand(0x25FB, 0x25FE),
		(0x27EF - 0x2600 + 1); rand(0x2600, 0x27EF),
		1; 0x2934,
		1; 0x2935,
		(0x2BFF - 0x2B00 + 1); rand(0x2B00, 0x2BFF),
		1; 0x3030,
		1; 0x303D,
		1; 0x3297,
		1; 0x3299,
		(0x1F02F - 0x1F000 + 1); rand(0x1F000, 0x1F02F),
		(0x1F0FF - 0x1F0A0 + 1); rand(0x1F0A0, 0x1F0FF),
		(0x1F64F - 0x1F100 + 1); rand(0x1F100, 0x1F64F),
		(0x1F6FF - 0x1F680 + 1); rand(0x1F680, 0x1F6FF),
		(0x1F96B - 0x1F910 + 1); rand(0x1F910, 0x1F96B),
		(0x1F9E0 - 0x1F980 + 1); rand(0x1F980, 0x1F9E0)
		))
	*/


/// Takes a hash generated by md5() and turns it into a string of alternating consonants and vowels
proc/md5_to_more_pronouncable(text)
	// not actually all consonants, only those that tend to make good sounding things
	var/list/consonants = list("b", "c", "d", "f", "g", "h", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "z")
	var/list/vowels = list("a", "e", "i", "o", "u")
	. = list()
	for(var/i in 1 to length(text) step 2)
		var/num = text2num(copytext(text, i, i + 2), 16) % (length(consonants) * length(vowels))
		. += consonants[num % length(consonants) + 1]
		. += vowels[round(num / length(consonants)) + 1]
	. = jointext(., "")
