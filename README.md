# Тестовое задание Flutter-разработчика

Что реализовано, что не совсем реализовано, а что было непонятно и
какие варианты решения были.

### 1 страница - страница с заданиями

- Категории на данный момент всего лишь список, который можно скроллить
  вправо и влево. При нажатии на них ничего не происходит (но в ТЗ пока что и не просят).
- Список задач, как и должен, приходит с API.
- Кнопка снизу действительно закреплена вне зависимости от прокрутки пользователя.
- Эффект Fade при переходе имеется.

### 2 страница - страница добавления заданий

- Валидацию тут особо и не придумать - одно поле текстовое, а другие поля - это пикер дат, времени и
  выпадающий список. Поэтому при нажатии кнопки "Добавить задание" проходит проверка на то, пустое ли
  текстовое поле и выбраны ли какие-то значения во всех остальных полях.
- В случае, если что-то не выбрано или не заполнено, кнопка блокируется и появляется небольшое
  уведомление внизу.
- В случае, если всё заполнено, появляется уведомление об успехе,
  по нажатию кнопки ОК происходит переход на страницу, где появилась новая задача.
  Она сохраняется только во время сеанса работы с приложением (после полного закрытия и открытия этой задачи уже не
  будет).
  Но сохраняется, как и просили.

### Дополнительный функционал

- Проверка наличия интернет-соединения - имеется в начале.
  Если человек заходит в приложение без интернета, ему показывается
  текст о том, что интернета нет. Весь функционал недоступен.
- Вход в приложение начинается с логотипа (так у всех приложений в андроиде),
  сначала появляется верхняя панель, потом прогружается информация с апи и появляется кнопка добавления задачи.
- Поиск по задачам реализован частично - можно вбить текст и найти задачу (текстовое поле появляется при нажатии на
  кнопку поиска в верхней панели), но при этом при уничтожении текста прежние задачи возвращаться не будут. Пока что не
  хватило времени разобраться с этим до конца, но эта задача вполне решаема.

### Ещё немного фич

- На первом экране желтый цвет - статус pending, зеленый цвет - completed.
  Так как на дизайне непонятно, нужно было сделать чекбоксы или нет, они были сделаны - можно нажать, и квадратик станет
  из зеленого/желтого белым. И наоборот.
- На втором экране можно заметить, что есть плейсхолдеры. Они серые. На всех кнопках, кроме выпадющих списков, при
  выборе чего-то / написании чего-то плэйсхолдеры больше не будут серыми, они станут черными.