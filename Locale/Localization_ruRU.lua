local LOCALE = GetLocale()
if not (LOCALE == "ruRU") then return end
local L = ArchiTotemLocale

L["Earthbind Totem"] = "Тотем оков земли"
L["Tremor Totem"] = "Тотем трепета"
L["Strength of Earth Totem"] = "Тотем силы земли"
L["Stoneskin Totem"] = "Тотем каменной кожи"
L["Stoneclaw Totem"] = "Тотем каменного когтя"
L["Searing Totem"] = "Опаляющий тотем"
L["Fire Nova Totem"] = "Тотем кольца огня"
L["Magma Totem"] = "Тотем магмы"
L["Frost Resistance Totem"] = "Тотем защиты от магии льда"
L["Flametongue Totem"] = "Тотем языка пламени"
L["Mana Spring Totem"] = "Тотем источника маны"
L["Mana Tide Totem"] = "Тотем прилива маны"
L["Fire Resistance Totem"] = "Тотем защиты от огня"
L["Poison Cleansing Totem"] = "Тотем противоядия"
L["Disease Cleansing Totem"] = "Тотем очищения от болезней"
L["Healing Stream Totem"] = "Тотем исцеляющего потока"
L["Tranquil Air Totem"] = "Тотем безветрия"
L["Grounding Totem"] = "Тотем заземления"
L["Windfury Totem"] = "Тотем неистовства ветра"
L["Grace of Air Totem"] = "Тотем легкости воздуха"
L["Nature Resistance Totem"] = "Тотем защиты от сил природы"
L["Windwall Totem"] = "Тотем стены ветра"
L["Sentry Totem"] = "Сторожевой тотем"

L["ver."] = "вер."
L["loaded"] = "загружен"
L["Earth totems shown: "] = "Количество отображаемых тотемов Земли: "
L["Fire totems shown: "] = "Количество отображаемых тотемов Огня: "
L["Water totems shown: "] = "Количество отображаемых тотемов Воды: "
L["Air totems shown: "] = "Количество отображаемых тотемов Воздуха: "
L["Direction set to: Down"] = "Направление установлено на: Вниз"
L["Direction set to: Up"] = "Направление установлено на: Вверх"
L["Order set to: "] = "Порядок установлен на: "
L["Scale set to: "] = "Масштаб установлен на: "
L["Showing all totems on mouseover"] = "Включено отображение всех тотемов при наведении курсора мыши"
L["Showing only one element on mouseover"] =
"Включено отображение тотемов только одной стихии при наведении курсора мыши"
L["Totems will move the the bottom line when cast"] = "Тотемы будут перемещаться на панель"
L["Totems will stay where they are when cast"] = "Тотемы останутся там, где они есть"
L["Timers are now turned on"] = "Таймеры включены"
L["Timers are now turned off"] = "Таймеры выключены"
L["Tooltips are now turned on"] = "Подсказки включены"
L["Tooltips are now turned off"] = "Подсказки выключены"
L["Debuging are now turned on"] = "Отладка включена"
L["Debuging are now turned off"] = "Отладка выключена"
L["Available commands:"] = "Доступные команды:"
L["/at set <earth/fire/water/air> # - Sets the totems shown of that element to #."] =
"/at set <earth/fire/water/air> # - Устанавливает количество отображаемых тотемов в этой стихии, на #."
L["/at direction <up/down> - Set the direction totems pop up."] =
"/at direction <up/down> - Устанавливает направление тотемов."
L["/at order <element 1, element 2, element 3, element 4> - Sets the order of the totems, from left to right."] =
"/at order <стихия 1, стихия 2, стихия 3, стихия 4> - Устанавливает порядок тотемов слева направо."
L["/at scale # - Sets the scale of ArchiTotem, default is 1."] =
"/at scale # - Устанавливает масштаб ArchiTotem, по умолчанию 1."
L["/at showall - Toggles show all mode, displaying all totems on mouseover."] =
"/at showall - Вкл./Выкл. отображение всех стихий, отображающих все тотемы при наведении курсора мыши."
L["/at bottomcast - Toggles moving totems to the bottom line when cast"] =
"/at bottomcast - Вкл./Выкл. перемещение тотемов на панель"
L["/at timers - Toggles showing timers"] = "/at timers - Вкл./Выкл. отображение таймеров"
L["/at tooltip - Toggles showing tooltips"] = "/at tooltip - Вкл./Выкл. отображение подсказок"
L["/at debug - Toggles debuging"] = "/at debug - Вкл./Выкл. отладку"
L["Moving the bar:"] = "Перемещение панели:"
L["Ctrl-RightClick and Drag any of the main buttons"] =
"Зажмите Ctrl+правую кнопку мыши и перетащите панель любую из основных кнопок"
L["Ordering totems of same element:"] = "Порядок тотемов:"
L["Ctrl-LeftClick any of the buttons"] = "Зажмите Ctrl+щелкните левой кнопкой мыши на любую из кнопок"
L["Unavailable command. Type /at for help."] = "Недоступная команда. Введите /at для помощи."
L["Elements must be written in english!"] = "Стихии должны быть записаны на английском!"
L["Direction must be down or up!"] = "Направление должно быть down или up!"
L["Scale must be a number!"] = "Масштаб должен быть числом!"
L["Specify scale"] = "Укажите масштаб!"

L["Cast Earth Totem"] = "Установка тотема земли"
L["Cast Fire Totem"] = "Установка тотема огня"
L["Cast Water Totem"] = "Установка тотема воды"
L["Cast Air Totem"] = "Установка тотема воздуха"

BINDING_NAME_CAST_EARTH_TOTEM = L["Cast Earth Totem"]
BINDING_NAME_CAST_FIRE_TOTEM = L["Cast Fire Totem"]
BINDING_NAME_CAST_WATER_TOTEM = L["Cast Water Totem"]
BINDING_NAME_CAST_AIR_TOTEM = L["Cast Air Totem"]
