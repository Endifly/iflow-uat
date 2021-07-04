class AnimationQueue {
  double from = 0.0;
  double to = 0.0;

  AnimationQueue({required this.from,required this.to});

  void add(double val) {
    this.from = this.to;
    this.to = val;
  }
}