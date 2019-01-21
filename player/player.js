var sound = new Howl({
  src: ['music/death.mp3']
})

function play(){
  sound.play();
}

function pause(){
  sound.pause();
}

function stop(){
  sound.stop();
}