enum Priority{
  high,
  medium,
  low,
  none
}
String getPriorityText(Priority priority){
  String text;

  switch(priority){
    case Priority.none:
      text = 'Нет';
      break;
    case Priority.high:
      text = 'Высокий';
      break;
    case Priority.medium:
      text = 'Средний';
      break;
    case Priority.low:
      text = 'Низкий';
      break;
  }

  return text;
}