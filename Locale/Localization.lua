local LOCALE = GetLocale()
ArchiTotemLocale = setmetatable({}, {
    __index = function(t, k)
        local v = tostring(k)
        rawset(t, k, v)
        if (LOCALE ~= "enUS") and (LOCALE ~= "enGB") then
            ArchiTotem_Print(string.format(" %q not found for %s", v, LOCALE), "debug")
        end
        return v
    end
})

local L = ArchiTotemLocale

if LOCALE == "esES" then
    L["Searing Totem"] = "Tótem Ardiente"
    L["Fire Nova Totem"] = "Totem de Nova de Fuego"
    L["Magma Totem"] = "Tótem de magma"
    L["Frost Resistance Totem"] = "Tótem de resistencia a la Escarcha"
    L["Flametongue Totem"] = "Tótem Lengua de Fuego"

    L["Earthbind Totem"] = "Tótem Atadura de Tierra"
    L["Tremor Totem"] = "Tótem de terremoto"
    L["Strength of Earth Totem"] = "Tótem Fuerza de la Tierra"
    L["Stoneskin Totem"] = "Tótem Piel de piedra"
    L["Stoneclaw Totem"] = "Tótem Garra de piedra"

    L["Mana Spring Totem"] = "Tótem de Maná Primordial"
    L["Fire Resistance Totem"] = "Tótem de resistencia al Fuego"
    L["Poison Cleansing Totem"] = "Tótem de Limpieza de Veneno"
    L["Disease Cleansing Totem"] = "Tótem de limpieza de enfermedades"
    L["Healing Stream Totem"] = "Tótem de Corriente Sanadora"

    L["Tranquil Air Totem"] = "Tótem de Aire Tranquilo"
    L["Grounding Totem"] = "Tótem de Apagado"
    L["Windfury Totem"] = "Tótem de Furia de Viento"
    L["Grace of Air Totem"] = "Tótem Gracia del Aire"
    L["Nature Resistance Totem"] = "Tótem de resistencia a la Naturaleza"
    L["Windwall Totem"] = "Tótem de Muro de Viento"
    L["Sentry Totem"] = "Tótem de centinela"

    L["Totemic Recall"] = "Recordar Totémico"

    L["Cast Earth Totem"] = "Lanzar Tótem de Tierra"
    L["Cast Fire Totem"] = "Lanzar Tótem de Fuego"
    L["Cast Water Totem"] = "Lanzar Tótem de Agua"
    L["Cast Air Totem"] = "Lanzar Tótem de Aire"
    L["Cast Totemic Recall"] = "Lanzar Retirada Totémica"

    -- Other translations
    L["ver."] = "versión"
    L["loaded"] = "cargado"
    L["Earth totems shown: "] = "Tótems de tierra mostrados: "
    L["Fire totems shown: "] = "Tótems de fuego mostrados: "
    L["Water totems shown: "] = "Tótems de agua mostrados: "
    L["Air totems shown: "] = "Tótems de aire mostrados: "
    L["Elements must be written in English!"] = "¡Los elementos deben escribirse en inglés!"
    L["Direction set to: Down"] = "Dirección establecida: Abajo"
    L["Direction set to: Up"] = "Dirección establecida: Arriba"
    L["Direction must be down or up!"] = "¡La dirección debe ser 'down' o 'up'!"
    L["Order set to: "] = "Orden establecido: "
    L["Specify scale"] = "Especifica la escala"
    L["Scale must be a number!"] = "¡La escala debe ser un número!"
    L["Scale set to: "] = "Escala establecida en: "
    L["Showing all totems on mouseover"] = "Mostrando todos los tótems al pasar el ratón"
    L["Showing only one element on mouseover"] = "Mostrando solo un elemento al pasar el ratón"
    L["Totems will move the the bottom line when cast"] = "Los tótems se moverán a la línea inferior al ser lanzados"
    L["Totems will stay where they are when cast"] = "Los tótems permanecerán donde están al ser lanzados"
    L["Timers are now turned on"] = "Los temporizadores están activados"
    L["Timers are now turned off"] = "Los temporizadores están desactivados"
    L["Tooltips are now turned on"] = "Las descripciones emergentes están activadas"
    L["Tooltips are now turned off"] = "Las descripciones emergentes están desactivadas"
    L["Debuging are now turned on"] = "La depuración está activada"
    L["Debuging are now turned off"] = "La depuración está desactivada"
    L["Available commands:"] = "Comandos disponibles:"
    L["/at set <earth/fire/water/air> # - Sets the totems shown of that element to #."] =
    "/at set <earth/fire/water/air> # - Define cuántos tótems de ese elemento se muestran."
    L["/at direction <up/down> - Set the direction totems pop up."] =
    "/at direction <up/down> - Establece la dirección de aparición de los tótems."
    L["/at order <element 1, element 2, element 3, element 4> - Sets the order of the totems, from left to right."] =
    "/at order <elemento1, elemento2, elemento3, elemento4> - Define el orden de los tótems de izquierda a derecha."
    L["/at scale # - Sets the scale of ArchiTotem, default is 1."] =
    "/at scale # - Establece la escala de ArchiTotem, valor por defecto es 1."
    L["/at showall - Toggles show all mode, displaying all totems on mouseover."] =
    "/at showall - Alterna mostrar todos los tótems al pasar el ratón."
    L["/at bottomcast - Toggles moving totems to the bottom line when cast"] =
    "/at bottomcast - Alterna mover los tótems a la línea inferior al lanzarlos."
    L["/at timers - Toggles showing timers"] = "/at timers - Alterna mostrar los temporizadores"
    L["/at tooltip - Toggles showing tooltips"] = "/at tooltip - Alterna mostrar descripciones emergentes"
    L["/at debug - Toggles debuging"] = "/at debug - Alterna la depuración"
    L["Moving the bar:"] = "Mover la barra:"
    L["Ctrl-RightClick and Drag any of the main buttons"] = "Ctrl-Clic Derecho y arrastra cualquier botón principal"
    L["Ordering totems of same element:"] = "Ordenar tótems del mismo elemento:"
    L["Ctrl-LeftClick any of the buttons"] = "Ctrl-Clic Izquierdo en cualquier botón"
    L["Unavailable command. Type /at for help."] = "Comando no disponible. Escribe /at para ayuda."
end

BINDING_NAME_CAST_EARTH_TOTEM = L["Cast Earth Totem"]
BINDING_NAME_CAST_FIRE_TOTEM = L["Cast Fire Totem"]
BINDING_NAME_CAST_WATER_TOTEM = L["Cast Water Totem"]
BINDING_NAME_CAST_AIR_TOTEM = L["Cast Air Totem"]
BINDING_NAME_CAST_TOTEMIC_RECALL = L["Cast Totemic Recall"]
