---
title: AdminHelper
layout: default
permalink: /adminhelper/index.html
tidied: true
---
[https://github.com/DigitalWand/digitalwand.admin_helper](https://github.com/DigitalWand/digitalwand.admin_helper)

**Основные преимущества**


- позволяет быстро создавать административные интерфейсы для сущностей ORM Битрикс
- повторяет интерфейсы "инфоблоков" - не надо будет переучивать менеджеров!
- легко расширяется, без написания лишнего кода - почувствуйте мощь ООП
- совместный вывод и управление записями и категориями этих записей
- возможность создания интерфейсов, не завязанных на ОРМ-моделях


Модуль реализует подход шаблона проектирования MVC в создании страниц для панели управления Битрикса.

Если у вас есть модель, написанная на ORM 1C-Битрикс, вы за считанные минуты сможете сделать раздел для управления данными этой модели, ничем не уступающему по своим возможностям и внешнему виду интерфейсу управления элементами инфоблоков.
Внешний вид полей и логика работы легко кастомизируется и дорабатывается разработчиками.

## Разработчики

Решение разработано совместно компаниями [DigitalWand](http://digitalwand.ru/) и [агенством Notamedia](http://nota.media) и активно используется в их проектах.

Решение хорошо показало себя на крупных и ответственных государственных проектах своей надёжностью и гибкостью.

## Что можно делать с помощью решения

**Кастомизируйте различные поля** с помощью так называемых "виджетов". Отображение каждого поля кастомизируется, как Вам заблагорассудится.
<img src="/img/ah_widgets.jpg"/>

**Экономьте время** на разворачивании и поддержке страниц админки. Прописывайте только то, что действительно относится к вашим страницам и не копируйте макароны с кодом. Оцените, например, страницу редактирования категорий на одном из проектов:
<img src="/img/ah_editpage.jpg"/>


## Как это использовать

- Установите [composer](https://getcomposer.org), если Вы ещё не сделали этого.<br/>
Как это правильно сделать в 1С-Битрикс [читайте в статье](/philosophy.html).

- Подключите зависимость `"digitalwand/digitalwand.admin_helper"` и укажите версию.<br/>
`composer require digitalwand/digitalwand.admin_helper`

- Создайте модуль, например `local/modules/demo.adminhelper`.<br/>
Обратите внимание, что все классы должны начинаться с неймспейса Demo\AdminHelper, чтобы работала автозагрузка классов.

- Создайте сущность в модуле.<br/>
В каталоге lib вашего модуля создайте каталог под сущность новостей: `demo.adminhelper/lib/news`. В нём мы будем размещать всё, что так или иначе связано с сущностью новостей.<br/>
А всё относящееся к интерфейсу панели управления Битрикса — положим в каталог `demo.adminhelper/lib/news/admininterface`.

- Создадим модель на базе ORM 1С-Битрикс:<br/>

```
<?php
namespace Demo\AdminHelper\News;

use Bitrix\Main\Entity\DataManager;
use Bitrix\Main\Localization\Loc;
use Bitrix\Main\Type\DateTime;

Loc::loadMessages(__FILE__);

/**
 * Модель новостей.
 */
class NewsTable extends DataManager
{
    /**
     * {@inheritdoc}
     */
    public static function getTableName()
    {
        return 'd_ah_news';
    }

    /**
     * {@inheritdoc}
     */
    public static function getMap()
    {
        return array(
            'ID' => array(
                'data_type' => 'integer',
                'primary' => true,
                'autocomplete' => true,
            ),
            'TITLE' => array(
                'data_type' => 'string',
                'title' => Loc::getMessage('DEMO_AH_NEWS_TITLE')
            ),
            'TEXT' => array(
                'data_type' => 'text',
                'title' => Loc::getMessage('DEMO_AH_NEWS_TEXT')
            ),
            // Для всех полей, используемых визивигом, нужно создавать в таблице атрибут с суффиксом _TEXT_TYPE.
            // В нём будет храниться информация о типе сохранённого контента (ХТМЛ или обычный текст).
            'TEXT_TEXT_TYPE' => array(
                'data_type' => 'string'
            ),
        );
    }
}
```



- Пропишем табы и отображение полей, отнаследовавшись от базового класса.<br/>
Также укажем, с помощью какого *виджета* отображать каждое из полей. Виджеты, в данном случае, - это специальные классы, отвечающие за отображение полей. Вы можете отнаследоваться от любого из существующих и отобразить, например, число в виде слайдера.

```
<?php

namespace Demo\AdminHelper\News\AdminInterface;

use Bitrix\Main\Localization\Loc;
use DigitalWand\AdminHelper\Helper\AdminInterface;
use DigitalWand\AdminHelper\Widget\DateTimeWidget;
use DigitalWand\AdminHelper\Widget\FileWidget;
use DigitalWand\AdminHelper\Widget\NumberWidget;
use DigitalWand\AdminHelper\Widget\StringWidget;
use DigitalWand\AdminHelper\Widget\UrlWidget;
use DigitalWand\AdminHelper\Widget\UserWidget;
use DigitalWand\AdminHelper\Widget\VisualEditorWidget;

Loc::loadMessages(__FILE__);

/**
 * Описание интерфейса (табок и полей) админки новостей.
 *
 * {@inheritdoc}
 */
class NewsAdminInterface extends AdminInterface
{
    /**
     * {@inheritdoc}
     */
    public function fields()
    {
        return array(
            'MAIN' => array(
                'NAME' => Loc::getMessage('DEMO_AH_NEWS'),
                'FIELDS' => array(
                'ID' => array(
                    'WIDGET' => new NumberWidget(),
                    'READONLY' => true,
                    'FILTER' => true,
                    'HIDE_WHEN_CREATE' => true
                ),
                'TITLE' => array(
                    'WIDGET' => new StringWidget(),
                    'SIZE' => '80',
                    'FILTER' => '%',
                    'REQUIRED' => true
                ),
                'TEXT' => array(
                    'WIDGET' => new VisualEditorWidget(),
                    'HEADER' => false
                ),
            )
        );
    }

    /**
    * {@inheritdoc}
    */
    public function helpers()
    {
        return array(
            '\Demo\AdminHelper\News\AdminInterface\NewsListHelper',
            '\Demo\AdminHelper\News\AdminInterface\NewsEditHelper'
        );
    }
}
```

- Создадим страницы списка новостей и редактирования отдельной новости.

```
<?php
namespace Demo\AdminHelper\News\AdminInterface;

use DigitalWand\AdminHelper\Helper\AdminListHelper;

/**
 * Хелпер описывает интерфейс, выводящий список новостей.
 * Обратите внимание, что нам достаточно прописать только класс, с которым будет работать список новостей - всё остальное модуль сделает сам!
 *
 * {@inheritdoc}
 */
class NewsListHelper extends AdminListHelper
{
	protected static $model = '\Demo\AdminHelper\News\NewsTable';
}
```

```
<?php
namespace Demo\AdminHelper\News\AdminInterface;

use DigitalWand\AdminHelper\Helper\AdminEditHelper;

/**
 * Хелпер описывает интерфейс, выводящий форму редактирования новости.
 *
 * {@inheritdoc}
 */
class NewsEditHelper extends AdminEditHelper
{
    protected static $model = '\Demo\AdminHelper\News\NewsTable';
}
```

- Наслаждайтесь собой!<br/>
За считанные минуты вы создали "тонкую" админку, которую легко кастомизировать и которой легко управлять. Ключевые файлы малы и легки в понимании, а сэкономленное время при поддержке решения (Вам теперь не придётся читать простыни кода!) Вы можете потратить с большей пользой.
