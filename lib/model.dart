import 'package:im_lab_9/base_generator.dart';
import 'package:logger/logger.dart';

class Model{
  final List<String> _answers = [
    'да',
    'возможно',
    'скорее всего',
    'не уверен',
    'спроси позже',
    'лучше не рассказывать',
    'маловероятно',
    'нет'
  ];
  final List<Segment> _segments = [];
  final _generator = DoubleBaseGenerator();

  Model(){
    final step = 1 / _answers.length;
    for(int i=0;i<_answers.length;i++){
      _segments.add(Segment(i*step, (i+1)*step));
    }
    Logger().i(_segments);
  }

  String get answer{
    final n = _generator.nextDouble;
    return _answers[_binarySearch(n)];
  }

  int _binarySearch(double target) {
    int low = 0;
    int high = _segments.length - 1;

    while (low <= high) {
      int mid = low + ((high - low) ~/ 2);
      int compareResult = _segments[mid].contain(target);

      if (compareResult == 0) {
        return mid;
      } else if (compareResult > 0) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return -1;
  }
}

class Segment{
  Segment(this.start, this.end);
  final double start;
  final double end;

  int contain(double point){
    if(point >= start && point < end) return 0;
    if(point < start) return -1;
    return 1;
  }

  @override
  String toString() {
    return 'Segment($start ; $end)';
  }
}