/datum/trader/generic
	// completely randomised generic trader
	hiketolerance = 20
	base_patience = list(4,20)
	chance_leave = 45
	chance_arrive = 66

	max_goods_buy = 5
	max_goods_sell = 4

	base_goods_buy = list(/datum/commodity/trader/generic/anyore,
	/datum/commodity/trader/generic/herbs,
	/datum/commodity/trader/generic/anyfood,
	/datum/commodity/trader/generic/shipcomponents,
	/datum/commodity/trader/generic/jumpsuits,
	/datum/commodity/trader/generic/furniture,
	/datum/commodity/trader/generic/pens)
	base_goods_sell = list(/datum/commodity/trader/generic/sheetmetal,
	/datum/commodity/trader/generic/rcd_ammo,
	/datum/commodity/trader/generic/fabric,
	/datum/commodity/trader/generic/telecrystal,
	/datum/commodity/trader/generic/glowstick,
	/datum/commodity/trader/generic/gasmask,
	/datum/commodity/trader/generic/monkey,
	/datum/commodity/trader/ringtone_dogs)
	/*
	/datum/commodity/trader/synthmodule/bacteria,
	/datum/commodity/trader/synthmodule/virii,
	/datum/commodity/trader/synthmodule/parasite,
	/datum/commodity/trader/synthmodule/fungi,
	/datum/commodity/trader/synthmodule/gmcell,
	/datum/commodity/trader/synthmodule/upgrader)
	*/
	New()
		..()
		var/pickfirstname = pick("Honest","Fair","Merchant","Trader","Kosher","Real Deal","Dealer","Sketchy","100%","Sassy","Zesty")
		var/picklastname = pick_string_autokey("names/last.txt")
		src.name = "[pickfirstname] [picklastname]"

		src.hiketolerance = rand(2,4)
		src.hiketolerance *= 10
		crate_tag = "TDR[rand(100,999)]"

// Traders are selling these things

/datum/commodity/trader/generic/sheetmetal
	comname = "Sheet Metal"
	comtype = /obj/item/sheet/steel
	price_boundary = list(5,10)
	possible_names = list("I'm selling sheets of construction-grade steel.",
	"I'm selling sheets of steel. Below market price, guaranteed!")

/datum/commodity/trader/generic/rcd_ammo
	comname = "RCD Charges"
	comtype = /obj/item/rcd_ammo
	amount = 25
	price_boundary = list(200,700)
	possible_names = list("We have RCD ammunition for sale.",
	"We have charges for RCD devices available for a good price!")

/datum/commodity/trader/generic/fabric
	comname = "Cloth Fabric"
	comtype = /obj/item/material_piece/cloth/cottonfabric
	price_boundary = list(60,70)
	possible_names = list("We have lots of cloth for sale. Good for making clothes with.",
	"We have a great deal of cloth we need to shift soon, so please buy it!")

/datum/commodity/trader/generic/telecrystal
	comname = "Telecrystals"
	comtype = /obj/item/raw_material/telecrystal
	amount = 20
	price_boundary = list(900,1200)
	possible_names = list("We have a limited amount of telecrystal available for purchase.",
	"We have raw telecrystal stones and no facilities to make use of them, so we're selling them instead.")

/datum/commodity/trader/generic/glowstick
	comname = "Glowsticks"
	comtype = /obj/item/device/light/glowstick
	amount = 100
	price_boundary = list(8,20)
	possible_names = list("We have a number of glowsticks available for purchase.",
	"We have come across some glowstick lighting supplies and have no use for them. Please buy them!")

/datum/commodity/trader/generic/gasmask
	comname = "Emergency Gas Masks"
	comtype = /obj/item/clothing/mask/gas/emergency
	amount = 25
	price_boundary = list(200, 500)
	possible_names = list("We have a surplus of gas masks. Need any?",
	"We seem to have ordered too many gas masks, so we're putting the extras up for sale.")

/datum/commodity/trader/generic/monkey
	comname = "Monkeys"
	comtype = /mob/living/carbon/human/npc/monkey
	amount = 4
	price_boundary = list(250, 1000)
	possible_names = list("We found a few stowaway monkeys on our ship. Feel free to take them off our hands.",
	"We seem to have a simian situation, and are selling them for a cheap price.")

/datum/commodity/trader/synthmodule
	comname = "Synth-O-Matic module"
	comtype = /obj/item/synthmodule
	desc = "A synth-o-matic module."
	price_boundary = list(7000, 11000)
	possible_names = list("We have some Synth-O-Matic upgrades for sale.",
	"We recently salvaged a couple of Synth-O-Matic machines, and we cannot make use of these spare parts.")

/datum/commodity/trader/synthmodule/vaccine
	comname = "Synth-O-Matic vaccine module"
	comtype = /obj/item/synthmodule/vaccine

/datum/commodity/trader/synthmodule/upgrader
	comname = "Synth-O-Matic efficiency module"
	comtype = /obj/item/synthmodule/upgrader

/datum/commodity/trader/synthmodule/assistant
	comname = "Synth-O-Matic assistant module"
	comtype = /obj/item/synthmodule/assistant

/datum/commodity/trader/synthmodule/synthesizer
	comname = "Synth-O-Matic synthesizer module"
	comtype = /obj/item/synthmodule/synthesizer

/datum/commodity/trader/synthmodule/virii
	comname = "Synth-O-Matic virus module"
	comtype = /obj/item/synthmodule/virii

/datum/commodity/trader/synthmodule/bacteria
	comname = "Synth-O-Matic bacterium module"
	comtype = /obj/item/synthmodule/bacteria

/datum/commodity/trader/synthmodule/fungi
	comname = "Synth-O-Matic fungus module"
	comtype = /obj/item/synthmodule/fungi

/datum/commodity/trader/synthmodule/parasite
	comname = "Synth-O-Matic parasite module"
	comtype = /obj/item/synthmodule/parasite

/datum/commodity/trader/synthmodule/gmcell
	comname = "Synth-O-Matic great mutatis cell module"
	comtype = /obj/item/synthmodule/gmcell

/datum/commodity/trader/synthmodule/radiation
	comname = "Synth-O-Matic irradiation module"
	comtype = /obj/item/synthmodule/radiation

/datum/commodity/trader/speedmodule
	comname = "Cloning upgrade system"
	comtype = /obj/item/cloneModule/speedyclone
	amount = 1
	price_boundary = list(8000,12000)
	possible_names = list("We have these new-fangled cloning upgrade modules lying around, but they are usless to our puritan crew.")

/datum/commodity/trader/efficiencymodule
	comname = "Cloning upgrade system"
	comtype = /obj/item/cloneModule/efficientclone
	amount = 1
	price_boundary = list(8000,12000)
	possible_names = list("We have these new-fangled cloning upgrade modules lying around, but they are useless to our puritan crew.")

/datum/commodity/trader/dnamodule
	comname = "Cloning upgrade system"
	comtype = /obj/item/cloneModule/genepowermodule
	amount = 1
	price_boundary = list(8000,12000)
	possible_names = list("We have these new-fangled cloning upgrade modules lying around, but they are useless to our puritan crew.")

/datum/commodity/trader/ringtone_dogs
	comname = "Wolf pack ringtone cartridge"
	comtype = /obj/item/disk/data/cartridge/ringtone_dogs
	amount = 1
	price_boundary = list(700000,900000)
	possible_names = list("Our captain is quite fond of this obnoxious PDA ringtone module, she may be willing to part with it for the right price. Please.")


// Traders want these things

/datum/commodity/trader/generic/anyore
	comname = "Ore"
	comtype = /obj/item/raw_material/
	price_boundary = list(60,230)
	possible_names = list("I'm looking to buy any kind of ore you might have.",
	"Our ore supplies are critically low - I'll buy any kind of ore for this price.")

/datum/commodity/trader/generic/anyfood
	comname = "Food"
	comtype = /obj/item/reagent_containers/food/snacks
	price_boundary = list(50,150)
	possible_names = list("We're ferrying food to the outer colonies, so sell us any extra you have.",
	"An accident has lost us most of our food supplies, so we're willing to buy any you may have.")

/datum/commodity/trader/generic/herbs
	comname = "Medical Herbs"
	comtype = /obj/item/plant/herb/
	price_boundary = list(75,200)
	possible_names = list("I'll buy any medical herbs you may have.",
	"I need to restock on medical herbs. I'm willing to buy them from you for a good price.")

/datum/commodity/trader/generic/shipcomponents
	comname = "Ship/Pod Components"
	comtype = /obj/item/shipcomponent/
	price_boundary = list(400,700)
	possible_names = list("Our shipyards are low on ship-building components. Could you sell us some?",
	"We're trying a new experimental pod construction technique and need all the ship components we can get.",
	"Some jokers sold us 600 cargo bays when we asked for parts, so we can't build any pods. We're in dire need of some other ship components.")

/datum/commodity/trader/generic/jumpsuits
	comname = "Jumpsuits"
	comtype = /obj/item/clothing/under/
	price_boundary = list(135,210)
	possible_names = list("We're drafting in some new staff soon, and need new jumpsuits.",
	"We need any jumpsuits you can spare. Don't ask.")


/datum/commodity/trader/generic/furniture
	comname = "Furniture Parts"
	comtype = /obj/item/furniture_parts/
	price_boundary = list(100, 350)
	possible_names = list("We need some more furniture to spice up our ship.",
	"We're building a new lounge, and we need whatever furniture you have.")

/datum/commodity/trader/generic/pens
	comname = "Writing Utensils"
	comtype = /obj/item/pen/
	price_boundary = list(80, 150)
	possible_names = list("We can't take notes! Send us something to write with, and make it snappy.",
	"Our crew's been really starved creatively. Give us something we can doodle with.")
