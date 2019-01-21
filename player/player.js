//Volume
var volume = document.getElementById("volume");
var progresso = document.getElementById("progresso");

// ----------------------------------
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

// Volume controll
volume.oninput = function() {  
  sound.volume((this.value)/100);
} 

// Music progression controll
progresso.oninput = function() {  
  if (sound.playing()){
    sound.seek(sound.duration() * (this.value/100));
  }
} 