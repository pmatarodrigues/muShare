
//Volume
var volume = document.getElementById("volume");
var progresso = document.getElementById("progresso");
var musAtual = document.getElementById("musAtual");


var sound;

function play(music, name){
  if(sound){

  }else{
    sound = new Howl({
      src: ['music/' + music]
    })
    musAtual.innerHTML = name;
  }
  if(sound.playing()){

  }else{
    sound.play();
  }   
}

function pause(){
  sound.pause();
}

function stop(){
  sound.stop();
  sound = null;
  musAtual.innerHTML = 'Sem Musica';
  document.getElementById('progresso').value=0;
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