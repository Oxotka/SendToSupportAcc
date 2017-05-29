﻿Функция ПараметрыОтправкиПисьма(Знач Объект) Экспорт

	ПараметрыОтправкиПисьма = Новый Структура;
	ПараметрыОтправкиПисьма.Вставить("Тема",       ТемаПисьмаПоОбъекту(Объект));
	ПараметрыОтправкиПисьма.Вставить("Получатель", АдресТехподдержки());
	ПараметрыОтправкиПисьма.Вставить("Текст",      ТекстПисьма(Объект));
	Возврат ПараметрыОтправкиПисьма;

КонецФункции

Функция АдресТехподдержки()

	Возврат "v8@1c.ru";

КонецФункции

Функция ТемаПисьмаПоОбъекту(Объект)

	Если ОбщегоНазначения.ВидОбъектаПоСсылке(Объект.Ссылка) = "Документ" Тогда
		ТекстОбъект = НСтр("ru='документе'");
	ИначеЕсли ОбщегоНазначения.ВидОбъектаПоСсылке(Объект.Ссылка) = "Справочник" Тогда
		ТекстОбъект = НСтр("ru='справочнике'");
	Иначе
		ТекстОбъект = НСтр("ru='объекте'");
	КонецЕсли;
	ТемаПисьма = СтрШаблон(НСтр("ru='Проблема в %1 %2'"), ТекстОбъект, Объект.Ссылка.Метаданные().Синоним);
	
	Возврат ТемаПисьма;
	
КонецФункции

Функция ТекстПисьма(Объект)

	ТекстПисьма = СтрШаблон(
		НСтр("ru='%1
		|Техническая информация:
		|
		|Объект: %2
		|Навигационная ссылка: %3 
		|СистемнаяИнформация: %4
		|ИнформационнаяБаза: %5'"),
		Символы.ПС + Символы.ПС + Символы.ПС + Символы.ПС + Символы.ПС,
		?(Объект.Ссылка.Пустая(),"новый " + Объект.Ссылка.Метаданные().Синоним,Объект.Ссылка),
		ПолучитьНавигационнуюСсылку(Объект.Ссылка),
		ТекстСистемнойИнформации(), 
		ОбщегоНазначения.ПолучитьПредставлениеИнформационнойБазы());
		
	Возврат ТекстПисьма;

КонецФункции

Функция ТекстСистемнойИнформации()

	СистемнаяИнформация = Новый СистемнаяИнформация;
	Текст = СтрШаблон(НСтр("ru='
		|Конфигурация: %1 %2
		|Платформа: %3
		|Пользователь: %4'"),
		Метаданные.Имя,
		Метаданные.Версия,
		СистемнаяИнформация.ВерсияПриложения, 
		Пользователи.ТекущийПользователь());
	
	Возврат Текст;

КонецФункции