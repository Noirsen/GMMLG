// Impor library yang benar untuk Video Export
import com.hamoid.VideoExport;

// Animasi Epos La Galigo (Versi Final 8) - Mode Rekam Video MP4
// UPDATE 8: Mengimplementasikan library Video Export untuk membuat file .mp4

// Variabel untuk Perekam Video
VideoExport videoExport;

// --- PENGATURAN MODE REKAM ---
// Ubah menjadi 'true' untuk merekam animasi sebagai file "LaGaligo.mp4".
// Ubah menjadi 'false' untuk menjalankan animasi secara normal tanpa merekam.
boolean recordMode = true;
// -----------------------------

// Variabel untuk mengontrol frame dan waktu
int currentFrame = 1;
long frameStartTime;
int frameDuration = 8000; // Durasi diperpanjang menjadi 8 detik

// Variabel global untuk mengontrol animasi
boolean isBlinking = false;
long lastBlinkTime = 0;
int blinkDuration = 150;
int blinkInterval = 2800;

boolean isTalking = false;
long lastTalkToggle = 0;
int talkToggleInterval = 220;

// Variabel untuk animasi Frame 1 (Ledakan Kosmik)
float explosionEffectRadius = 0;
int numExplosionParticles = 200;
ExplosionParticle[] explosionParticles = new ExplosionParticle[numExplosionParticles];
boolean explosionStarted = false;

// Variabel untuk animasi terbang (Frame 4 & 8)
float flyingBobOffset = 0;
float auraAlpha = 0;

// Variabel untuk animasi Frame 6 (Berjalan Sendirian)
float walkX = -100;

// Variabel untuk animasi Frame 9 (Jatuh cinta)
float heartSize = 0;

// Variabel untuk animasi Frame 11 (Bola bercahaya)
float orbSplitProgress = 0;

// Variabel untuk animasi Frame 14 (Daun jatuh)
ArrayList<Leaf> fallingLeaves;

// Variabel untuk animasi menangis (Frame 17)
ArrayList<Tear> tears;
boolean isCrying = false;

// Variabel untuk animasi Frame 19 (Pohon menebang)
float treeCrackProgress = 0;

// Variabel untuk animasi kapal bergerak
float shipX = -300;
float waveOffset = 0;

// Variabel untuk gerakan awan yang halus
float cloudOffset = 0;
float noiseSeed;

// Subtitles (Naskah Voiceover yang lebih mengalir dan sopan)
String[] subtitles = {
  "Dari ketiadaan, dua kekuatan kosmik bertemu, melahirkan ledakan cahaya yang menjadi awal mula segala kehidupan.", // Frame 1
  "Di atas lapisan awan, berdirilah istana megah Boting Langi, kediaman para dewa yang damai dan tenteram.", // Frame 2
  "Batara Guru, penguasa dunia atas, memanggil putranya, Batara Guru Lolo ri Sérenaé, untuk sebuah tugas suci.", // Frame 3
  "Dengan restu sang ayah, Batara Guru Lolo ri Sérenaé melayang turun dari langit, membawa takdir baru bagi dunia tengah.", // Frame 4
  "Ia mendarat dengan perkasa di bumi yang masih murni, sebuah pertanda dimulainya sebuah era baru.", // Frame 5
  "Sendirian, ia menapaki tanah Sulawesi, menyusuri gunung dan lembah dalam perjalanannya mencari tujuan.", // Frame 6
  "Dunia tengah terhampar luas di hadapannya. Lanskap alam yang indah dan belum terjamah.", // Frame 7
  "Dari ketinggian, matanya menangkap sosok anggun di bawah sana. We Nyili Timo, dewi dari dunia bawah.", // Frame 8
  "Di tengah padang ilalang, dua insan dari dua dunia berbeda bertemu. Benih-benih cinta pertama pun bersemi.", // Frame 9
  "Dari cinta mereka, lahirlah silsilah keturunan yang akan menjadi cikal bakal para pahlawan besar di tanah Bugis.", // Frame 10
  "Bertahun-tahun kemudian, seorang anak bernama Sawerigading menemukan sebuah pusaka kuno yang menyimpan takdirnya.", // Frame 11
  "Tanpa ia sadari, di tempat lain, saudara kembarnya, We Tenriabéng, tumbuh terpisah darinya oleh takdir.", // Frame 12
  "Keduanya tumbuh dewasa. Sawerigading menjadi pahlawan gagah, sementara We Tenriabéng menjadi putri jelita.", // Frame 13
  "Takdir mempertemukan mereka dalam sebuah pertemuan singkat, tanpa tahu ikatan darah yang menyatukan mereka.", // Frame 14
  "Namun, Sawerigading harus melanjutkan perjalanannya, meninggalkan pertemuan itu dengan langkah yang terasa berat.", // Frame 15
  "Di hadapan ayahnya, Batara Lattu, Sawerigading mendengar sebuah ramalan yang akan mengubah jalan hidupnya.", // Frame 16
  "Hatinya hancur mengetahui tak bisa menikahi We Tenriabéng. Dalam tangisnya, sebuah tekad baru lahir.", // Frame 17
  "Di bawah sinar rembulan, Sawerigading bersumpah. Ia akan membangun kapal untuk mencari cinta sejatinya yang lain.", // Frame 18
  "Dengan kapak pusaka, ia menebang pohon Welenreng, pohon raksasa yang kayunya akan menjadi bahan kapalnya.", // Frame 19
  "Bersama para pengrajin dan Bissu, kayu keramat itu mulai dibentuk menjadi sebuah kapal yang megah.", // Frame 20
  "Kapal itu pun selesai, berdiri gagah di tepi sungai. Para Bissu memberkatinya dengan doa dan ritual suci.", // Frame 21
  "Sawerigading memimpin armadanya, berlayar membelah lautan luas menuju negeri asing yang jauh.", // Frame 22
  "Di tengah lautan, badai dan musuh menghadang. Namun, keberanian Sawerigading tak pernah goyah.", // Frame 23
  "Akhirnya, kapalnya berlabuh di pantai, sebuah daratan asing yang penuh harapan.", // Frame 24
  "Di sana, ia bertemu We Cudaiq, seorang putri yang wajahnya begitu mirip dengan saudara kembarnya.", // Frame 25
  "Dari pernikahan mereka, lahirlah seorang putra yang diberi nama La Galigo, sang pewaris takdir.", // Frame 26
  "Inilah potret keluarga mereka. Awal dari sebuah epos besar yang akan dikenang sepanjang masa.", // Frame 27
  "La Galigo tumbuh menjadi pemuda bijaksana, melanjutkan petualangan sang ayah dengan kapalnya sendiri.", // Frame 28
  "Ia mengumpulkan kisah-kisah para leluhur, menuliskannya di atas daun lontar agar tak lekang oleh waktu.", // Frame 29
  "Kisah La Galigo mengajarkan tentang keberanian, cinta, dan takdir. Sebuah warisan abadi pengingat kebesaran budaya." // Frame 30 (Amanat)
};

void setup() {
  size(1200, 675); // Ukuran kanvas landscape (16:9)
  frameStartTime = millis();
  
  // *** PERUBAHAN 1: Inisialisasi VideoExport ***
  if (recordMode) {
    // Inisialisasi objek. File video akan bernama "LaGaligo.mp4".
    videoExport = new VideoExport(this, "LaGaligo.mp4");
    // Atur framerate video. 30 FPS adalah standar yang baik.
    videoExport.setFrameRate(30);
    // Mulai proses perekaman
    videoExport.startMovie();
  }
  
  // Inisialisasi ArrayList SEBELUM digunakan.
  fallingLeaves = new ArrayList<Leaf>();
  tears = new ArrayList<Tear>();
  
  noiseSeed = random(1000); // Seed untuk noise awan agar konsisten

  resetFrameAnimations();  
}

void draw() {
  long elapsedTime = millis() - frameStartTime;
  
  int currentFrameDuration = frameDuration;
  if (currentFrame == 10) {
      currentFrameDuration = 12000; // Durasi lebih lama untuk silsilah
  }

  // Update animasi global
  updateBlinking();
  cloudOffset += 0.0003; 

  // Pindah frame jika durasi habis
  if (elapsedTime > currentFrameDuration) {
    currentFrame++;
    frameStartTime = millis();
    elapsedTime = 0;

    if (currentFrame > subtitles.length) {
      if (recordMode) {
        println("Selesai merekam semua frame. Sekarang memproses video...");
        // *** PERUBAHAN 2: Finalisasi video sebelum keluar ***
        videoExport.endMovie(); 
        exit(); // Keluar dari program setelah selesai merekam
      }
      currentFrame = 1; // Kembali ke awal jika tidak sedang merekam
    }
    resetFrameAnimations();
  }

  // Gambar frame saat ini
  drawCurrentFrame(elapsedTime);
  
  // Gambar subtitle (kecuali untuk frame terakhir yang punya perlakuan khusus)
  if (currentFrame != 30) {
    drawSubtitle();
  }
  
  // Simpan frame jika mode rekam aktif
  if (recordMode) {
    // *** PERUBAHAN 3: Gunakan videoExport untuk menyimpan frame ***
    videoExport.saveFrame();
  }
}

void updateBlinking() {
  if (millis() - lastBlinkTime > blinkInterval + random(-500, 500)) {
    isBlinking = true;
    lastBlinkTime = millis();
  }
  if (isBlinking && millis() - lastBlinkTime > blinkDuration) {
    isBlinking = false;
  }
}

void updateTalking(boolean isSceneWithDialogue) {
    if (isSceneWithDialogue && millis() - lastTalkToggle > talkToggleInterval) {
        isTalking = !isTalking;
        lastTalkToggle = millis();
    } else if (!isSceneWithDialogue) {
        isTalking = false; // Mulut diam jika tidak ada dialog
    }
}


void resetFrameAnimations() {
  // Reset semua variabel animasi
  explosionEffectRadius = 0;
  explosionStarted = false;
  walkX = -100;
  heartSize = 0;
  orbSplitProgress = 0;
  treeCrackProgress = 0;
  shipX = -300;
  waveOffset = 0;
  isCrying = false;
  auraAlpha = 0;
  
  fallingLeaves.clear();
  tears.clear();
  
  // Inisialisasi partikel ledakan
  if (explosionParticles.length > 0) {
    for (int i = 0; i < numExplosionParticles; i++) {
      explosionParticles[i] = new ExplosionParticle(width / 2, height / 2);
    }
  }
}

void drawCurrentFrame(long elapsedTime) {
    boolean hasDialogue = (currentFrame == 3 || currentFrame == 14 || currentFrame == 16 || currentFrame == 29);
    updateTalking(hasDialogue);

    switch (currentFrame) {
        case 1: drawFrame1(elapsedTime); break;
        case 2: drawFrame2(elapsedTime); break;
        case 3: drawFrame3(elapsedTime); break;
        case 4: drawFrame4(elapsedTime); break;
        case 5: drawFrame5(elapsedTime); break;
        case 6: drawFrame6(elapsedTime); break;
        case 7: drawFrame7(elapsedTime); break;
        case 8: drawFrame8(elapsedTime); break;
        case 9: drawFrame9(elapsedTime); break;
        case 10: drawFrame10(elapsedTime); break;
        case 11: drawFrame11(elapsedTime); break;
        case 12: drawFrame12(elapsedTime); break;
        case 13: drawFrame13(elapsedTime); break;
        case 14: drawFrame14(elapsedTime); break;
        case 15: drawFrame15(elapsedTime); break;
        case 16: drawFrame16(elapsedTime); break;
        case 17: drawFrame17(elapsedTime); break;
        case 18: drawFrame18(elapsedTime); break;
        case 19: drawFrame19(elapsedTime); break;
        case 20: drawFrame20(elapsedTime); break;
        case 21: drawFrame21(elapsedTime); break;
        case 22: drawFrame22(elapsedTime); break;
        case 23: drawFrame23(elapsedTime); break;
        case 24: drawFrame24(elapsedTime); break;
        case 25: drawFrame25(elapsedTime); break;
        case 26: drawFrame26(elapsedTime); break;
        case 27: drawFrame27(elapsedTime); break;
        case 28: drawFrame28(elapsedTime); break;
        case 29: drawFrame29(elapsedTime); break;
        case 30: drawFrame30(elapsedTime); break;
    }
}

// --- FUNGSI GAMBAR SETIAP FRAME ---
// (Tidak ada perubahan di bawah sini, semua fungsi gambar frame tetap sama)

void drawFrame1(long elapsedTime) {
  background(10, 0, 20); 
  float progress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (!explosionStarted) {
      explosionStarted = true;
      for (int i = 0; i < numExplosionParticles; i++) {
        explosionParticles[i] = new ExplosionParticle(width / 2, height / 2);
      }
  }
  for (ExplosionParticle p : explosionParticles) {
    p.update(progress);
    p.display();
  }
  for (int i = 0; i < 4; i++) {
    float currentWaveRadius = progress * max(width, height) * (0.2 + i * 0.2);
    float alpha = map(progress, i*0.2, 1.0, 255, 0);
    stroke(255, 255, 220, alpha);
    strokeWeight(3);
    noFill();
    ellipse(width / 2, height / 2, currentWaveRadius, currentWaveRadius);
  }
}

void drawFrame2(long elapsedTime) {
  background(135, 206, 250);
  drawSmoothClouds(0, height * 0.9, 5, false);
  drawSmoothClouds(width/2, height * 0.85, 3, false);
  drawSmoothClouds(width/2, height * 0.65, 1, true);
  float palaceX = width / 2;
  float palaceY = height * 0.4;
  float floatOffset = sin(millis() * 0.0005) * 8;
  float palaceAlpha = map(elapsedTime, 0, frameDuration / 2, 0, 255);
  drawDetailedPalace(palaceX, palaceY + floatOffset, 1.2, palaceAlpha);
}

void drawFrame3(long elapsedTime) {
  drawPalaceHallBackground();
  drawBataraGuru(width * 0.6, height * 0.65, 1.1, true);
  drawAdvisor(width * 0.35, height * 0.65, 1.0);
}

void drawFrame4(long elapsedTime) {
  background(135, 206, 250);
  drawGround(height*0.9, color(144, 238, 144));
  drawSmoothClouds(0, height * 0.4, 4, false);
  drawSmoothClouds(width/2, height * 0.8, 2, false);
  float progress = map(elapsedTime, 0, frameDuration, 0, 1);
  float descentY = lerp(-200, height * 0.5, progress);
  flyingBobOffset = sin(millis() * 0.002) * 10;
  auraAlpha = lerp(0, 150, progress);
  drawBataraGuruLolo(width / 2, descentY + flyingBobOffset, 1.2, "flying");
}

void drawFrame5(long elapsedTime) {
  background(144, 238, 144);
  drawGround(height*0.8, color(124, 202, 124));
  drawSmoothClouds(0, height * 0.3, 4, false);
  drawDetailedTree(width * 0.1, height * 0.8, 1.0);
  drawDetailedTree(width * 0.9, height * 0.8, 1.2);
  float progress = map(elapsedTime, 0, frameDuration, 0, 1);
  drawBataraGuruLoloLanding(width / 2, height * 0.85, progress);
}

void drawFrame6(long elapsedTime) {
  background(173, 216, 230);
  drawGround(height*0.7, color(144, 238, 144));
  drawSmoothClouds(width/2, height * 0.2, 3, false);
  drawDetailedMountain(width * 0.5, height*0.7, 800, 400);
  drawDetailedRiver(0, height * 0.8, width, 100);
  drawDetailedTree(width * 0.2, height * 0.7, 1.1);
  walkX = map(elapsedTime, 0, frameDuration, -100, width + 100);
  drawBataraGuruLolo(walkX, height * 0.75, 1.0, "walking");
}

void drawFrame7(long elapsedTime) {
  background(173, 216, 230);
  drawGround(height*0.7, color(34, 139, 34));
  drawSmoothClouds(0, height * 0.25, 5, false);
  drawDetailedMountain(width * 0.2, height*0.7, 600, 300);
  drawDetailedMountain(width * 0.8, height*0.7, 700, 350);
  float progress = (float)elapsedTime / frameDuration;
  for (int i=0; i<5; i++) {
      float birdX = lerp(-100 - i * 150, width + 100, progress);
      float birdY = height * 0.3 + sin(birdX * 0.02) * 30 + i*20;
      drawRealisticBird(birdX, birdY, 25);
  }
}

void drawFrame8(long elapsedTime) {
  background(135, 206, 250);
  drawGround(height*0.7, color(34, 139, 34));
  drawSmoothClouds(width/2, height * 0.3, 3, false);
  flyingBobOffset = sin(millis() * 0.002) * 10;
  auraAlpha = 150;
  drawBataraGuruLolo(width/2, height*0.3 + flyingBobOffset, 1.0, "flying");
  drawDetailedTree(width * 0.2, height * 0.7, 1.2);
  drawDetailedTree(width * 0.8, height * 0.7, 1.2);
  drawWeNyiliTimo(width/2, height * 0.8, 0.9);
}

void drawFrame9(long elapsedTime) {
  background(218, 165, 32);
  drawGround(height*0.75, color(200, 150, 30));
  drawDetailedGrass(height * 0.8, 50, 20);
  drawBataraGuruLolo(width * 0.35, height * 0.75, 1.1, "normal");
  drawWeNyiliTimo(width * 0.65, height * 0.75, 1.1);
  heartSize = map(elapsedTime, 1000, frameDuration, 0, 60);
  if(heartSize > 0) {
      drawHeart(width/2, height * 0.4, heartSize);
  }
}

void drawFrame10(long elapsedTime) {
  background(245, 245, 220);
  drawFamilyTree(width/2, height, elapsedTime);
}

void drawFrame11(long elapsedTime) {
  background(101, 67, 33);
  fill(87, 58, 29);
  stroke(40);
  strokeWeight(4);
  rect(width/2 - 100, height * 0.7, 200, 120, 10);
  noStroke();
  if (elapsedTime < 2000) {
    drawSawerigadingChild(width/2, height * 0.75, 0.8, "normal");
  } else {
    drawSawerigadingChild(width/2, height * 0.75, 0.8, "surprised");
  }
  orbSplitProgress = map(elapsedTime, 1000, frameDuration, 0, 1);
  float orbSize = 50;
  float splitOffset = orbSplitProgress * 40;
  fill(255, 255, 224, 200);
  ellipse(width/2 - splitOffset, height * 0.6, orbSize, orbSize);
  ellipse(width/2 + splitOffset, height * 0.6, orbSize, orbSize);
}

void drawFrame12(long elapsedTime) {
  pushMatrix();
  clip(0, 0, width/2, height);
  background(144, 238, 144);
  drawGround(height*0.7, color(124, 202, 124));
  drawDetailedTree(width * 0.1, height * 0.7, 1.0);
  drawSawerigadingChild(width * 0.25, height * 0.7, 1.0, "normal");
  popMatrix();
  
  pushMatrix();
  clip(width/2, 0, width/2, height);
  background(255, 182, 193);
  drawGround(height*0.7, color(245, 172, 183));
  drawDetailedFlower(width * 0.6, height * 0.7, 50);
  drawDetailedFlower(width * 0.9, height * 0.7, 50);
  drawWeTenriabengChild(width * 0.75, height * 0.7, 1.0);
  popMatrix();
  
  noClip();
  
  stroke(255, 255, 224, 150);
  strokeWeight(8);
  line(width/2, 0, width/2, height);
}

void drawFrame13(long elapsedTime) {
    pushMatrix();
    clip(0, 0, width/2, height);
    drawPalaceHallBackground();
    drawSawerigadingAdult(width * 0.25, height * 0.7, 1.1, "normal");
    popMatrix();
    
    pushMatrix();
    clip(width/2, 0, width/2, height);
    background(255, 182, 193);
    drawGround(height*0.7, color(245, 172, 183));
    drawDetailedFlower(width * 0.6, height * 0.7, 50);
    drawWeTenriabengAdult(width * 0.75, height * 0.7, 1.1);
    popMatrix();

    noClip();

    stroke(255, 255, 224, 100);
    strokeWeight(8);
    line(width/2, 0, width/2, height);
}

void drawFrame14(long elapsedTime) {
  background(173, 216, 230);
  drawGround(height*0.65, color(153, 206, 210));
  drawSmoothClouds(0, height * 0.2, 5, false);
  drawDetailedTree(width * 0.2, height * 0.65, 1.5);
  drawDetailedTree(width * 0.8, height * 0.65, 1.5);
  fill(139, 69, 19);
  rect(width/2 - 150, height * 0.7, 300, 30, 5);
  rect(width/2 - 140, height * 0.7 + 30, 20, 50);
  rect(width/2 + 120, height * 0.7 + 30, 20, 50);
  drawSawerigadingAdult(width * 0.4, height * 0.7, 1.0, "normal");
  drawWeTenriabengAdult(width * 0.6, height * 0.7, 1.0);
  if (random(1) < 0.2) {
    fallingLeaves.add(new Leaf(random(width), -20));
  }
  for (int i = fallingLeaves.size() - 1; i >= 0; i--) {
    Leaf leaf = fallingLeaves.get(i);
    leaf.update();
    leaf.display();
    if (leaf.isDead()) {
      fallingLeaves.remove(i);
    }
  }
}

void drawFrame15(long elapsedTime) {
  background(173, 216, 230);
  drawSmoothClouds(0, height*0.2, 4, false);
  drawDetailedPalace(width * 0.8, height * 0.5, 0.6, 255);
  fill(210, 180, 140);
  noStroke();
  quad(0, height * 0.7, width, height * 0.7, width, height, 0, height);
  float walkProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  float currentWalkX = lerp(width * 0.2, width * 0.7, walkProgress);
  drawSawerigadingAdult(currentWalkX, height * 0.75, 1.1, "walking_back");
}

void drawFrame16(long elapsedTime) {
  drawPalaceHallBackground();
  drawBataraLattu(width * 0.65, height * 0.6, 1.2);
  drawSawerigadingAdult(width * 0.35, height * 0.7, 1.1, "sad");
}

void drawFrame17(long elapsedTime) {
  background(144, 238, 144);
  drawGround(height*0.8, color(124, 202, 124));
  drawDetailedTree(width * 0.4, height*0.8, 2.0);
  float progress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (progress < 0.6) {
    isCrying = true;
    drawSawerigadingAdult(width/2, height*0.8, 1.0, "despair");
  } else {
    isCrying = false;
    drawSawerigadingAdult(width/2, height*0.8, 1.0, "idea");
    drawIdeaIcon(width/2 + 60, height * 0.8 - 180);
  }
}

void drawFrame18(long elapsedTime) {
  background(25, 25, 112);
  fill(255, 255, 224);
  for(int i=0; i<100; i++) {
    ellipse(random(width), random(height*0.8), 2, 2);
  }
  ellipse(width * 0.8, height * 0.2, 100, 100);
  fill(139, 69, 19);
  rect(0, height * 0.8, width, height * 0.2);
  drawSawerigadingAdult(width/2, height * 0.75, 1.2, "vowing");
}

void drawFrame19(long elapsedTime) {
  background(135, 206, 250);
  drawGround(height*0.8, color(24, 119, 24));
  drawSmoothClouds(0, height*0.2, 5, false);
  float progress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (progress < 0.7) {
    drawDetailedTree(width * 0.7, height*0.8, 2.0);
    drawSawerigadingAdult(width * 0.3, height * 0.8, 1.1, "chopping");
    treeCrackProgress = map(progress, 0.4, 0.7, 0, 1);
    if(treeCrackProgress > 0) {
        stroke(0);
        strokeWeight(4);
        line(width * 0.7 - 20, height * 0.8, width * 0.7 + 20, height * 0.75);
    }
  } else {
    float fallRotation = map(progress, 0.7, 1, 0, HALF_PI);
    pushMatrix();
    translate(width * 0.7, height*0.8);
    rotate(fallRotation);
    drawDetailedTree(0, 0, 2.0);
    popMatrix();
  }
}

void drawFrame20(long elapsedTime) {
  background(210, 180, 140);
  drawGround(height*0.8, color(222, 184, 135));
  fill(139, 69, 19);
  rect(width*0.1, height*0.7, width*0.8, 100, 20);
  drawSawerigadingAdult(width * 0.8, height * 0.7, 1.0, "normal");
  drawCraftsman(width * 0.25, height * 0.7, 0.9, "working");
  drawCraftsman(width * 0.5, height * 0.7, 0.9, "working");
}

void drawFrame21(long elapsedTime) {
  background(135, 206, 250);
  drawSmoothClouds(0, height*0.2, 5, false);
  fill(0, 191, 255);
  rect(0, height * 0.7, width, height * 0.3);
  drawDetailedShip(width/2, height*0.6, 1.0, false);
  drawBissu(width * 0.7, height * 0.65, 0.9);
}

void drawFrame22(long elapsedTime) {
  background(70, 130, 180);
  waveOffset = (millis() * 0.005);
  drawDetailedWaves(waveOffset);
  shipX = map(elapsedTime, 0, frameDuration, -300, width + 300);
  float shipY = height * 0.6 + sin(millis() * 0.001) * 10;
  drawDetailedShip(shipX, shipY, 1.0, true);
  drawSawerigadingAdult(shipX, shipY - 120, 0.8, "normal");
}

void drawFrame23(long elapsedTime) {
    background(47, 79, 79);
    waveOffset = (millis() * 0.01);
    drawDetailedWaves(waveOffset);
    float shipY = height * 0.6 + sin(millis() * 0.005) * 20;
    pushMatrix();
    translate(width*0.3, shipY);
    rotate(radians(sin(millis() * 0.008) * 8));
    drawDetailedShip(0, 0, 1.0, true);
    drawSawerigadingAdult(0, -120, 0.7, "normal");
    popMatrix();
    pushMatrix();
    translate(width*0.7, shipY + 10);
    rotate(radians(sin(millis() * 0.007) * -8));
    drawDetailedShip(0, 0, 0.9, true);
    drawEnemyWarrior(0, -110, 0.7);
    popMatrix();
    if(random(1) < 0.1) {
        drawLightning(random(width), 0, 5, 10, random(2,5));
    }
}

void drawFrame24(long elapsedTime) {
    background(135, 206, 250);
    drawSmoothClouds(0, height*0.2, 5, false);
    fill(244, 164, 96);
    rect(0, height * 0.8, width, height * 0.2);
    drawPalmTree(width*0.1, height*0.8, 1.2);
    drawPalmTree(width*0.9, height*0.8, 1.2);
    float shipX = map(elapsedTime, 0, frameDuration, -300, width * 0.3);
    drawDetailedShip(shipX, height * 0.7, 1.0, false);
}

void drawFrame25(long elapsedTime) {
    background(255, 182, 193);
    drawGround(height*0.7, color(245, 172, 183));
    drawDetailedFlower(width*0.2, height*0.7, 100);
    drawDetailedFlower(width*0.8, height*0.7, 100);
    float approachOffset = map(elapsedTime, 0, frameDuration, 100, 0);
    drawSawerigadingAdult(width * 0.5 - 50 - approachOffset, height * 0.7, 1.1, "normal");
    drawWeCudaiq(width * 0.5 + 50 + approachOffset, height * 0.7, 1.1);
    heartSize = map(elapsedTime, 2000, frameDuration, 0, 60);
    if(heartSize > 0) {
        drawHeart(width/2, height * 0.4, heartSize);
    }
}

void drawFrame26(long elapsedTime) {
    drawPalaceHallBackground();
    fill(160, 82, 45);
    rect(width*0.2, height*0.7, width*0.6, 100, 10);
    drawWeCudaiqHoldingBaby(width*0.6, height*0.65, 1.1);
    drawSawerigadingAdult(width*0.35, height*0.68, 1.1, "normal");
}

void drawFrame27(long elapsedTime) {
    drawPalaceHallBackground();
    stroke(87, 58, 29);
    strokeWeight(20);
    fill(240, 230, 210);
    rect(width*0.2, height*0.1, width*0.6, height*0.8);
    noStroke();
    fill(135, 206, 250);
    rect(width*0.2 + 10, height*0.1 + 10, width*0.6 - 20, height*0.8 * 0.7);
    fill(124, 202, 124);
    rect(width*0.2 + 10, height*0.1 + 10 + height*0.8 * 0.7, width*0.6 - 20, height*0.8 * 0.3 - 20);
    drawSawerigadingAdult(width*0.4, height*0.7, 1.0, "normal");
    drawWeCudaiq(width*0.6, height*0.7, 1.0);
    drawLaGaligoToddler(width*0.5, height*0.75, 0.8);
}

void drawFrame28(long elapsedTime) {
  background(70, 130, 180);
  waveOffset = (millis() * 0.005);
  drawDetailedWaves(waveOffset);
  shipX = map(elapsedTime, 0, frameDuration, -300, width + 300);
  float shipY = height * 0.6 + sin(millis() * 0.001) * 10;
  drawDetailedShip(shipX, shipY, 1.0, true);
  drawLaGaligoAdult(shipX, shipY - 120, 0.8, "normal");
}

void drawFrame29(long elapsedTime) {
    drawPalaceHallBackground();
    fill(139, 69, 19);
    rect(width*0.2, height*0.8, width*0.6, 50, 10);
    drawLaGaligoAdult(width*0.5, height*0.75, 1.1, "writing");
    drawElder(width*0.25, height*0.75, 1.0);
    drawElder(width*0.75, height*0.75, 1.0);
    fill(255, 235, 205);
    rect(width*0.4, height*0.7, 100, 30);
}

void drawFrame30(long elapsedTime) {
    background(0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(subtitles[29], width * 0.1, height/2 - 100, width * 0.8, 200);
    float fadeAlpha = map(elapsedTime, frameDuration - 2000, frameDuration, 255, 0);
    if (fadeAlpha < 255) {
        fill(0, 255 - fadeAlpha);
        noStroke();
        rect(0,0,width,height);
    }
}


// --- KELAS DAN FUNGSI GAMBAR PEMBANTU ---

class ExplosionParticle {
  PVector pos, vel;
  float life;
  color c;
  ExplosionParticle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(random(1, 5));
    life = 255;
    c = color(random(220, 255), random(200, 255), random(180, 220));
  }
  void update(float progress) {
    pos.add(vel);
    vel.mult(0.99);
    life = lerp(255, 0, progress*1.5);
  }
  void display() {
    noStroke();
    fill(c, life);
    ellipse(pos.x, pos.y, 5, 5);
  }
}

class Leaf {
  PVector pos;
  float speed, rotation, rotationSpeed, size;
  Leaf(float x, float y) {
    pos = new PVector(x, y);
    speed = random(1, 3);
    rotation = 0;
    rotationSpeed = random(-0.05, 0.05);
    size = random(15, 25);
  }
  void update() {
    pos.y += speed;
    pos.x += sin(pos.y * 0.05) * 2;
    rotation += rotationSpeed;
  }
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    fill(210, 105, 30, 200);
    noStroke();
    ellipse(0, 0, size, size * 0.6);
    popMatrix();
  }
  boolean isDead() { return pos.y > height + 20; }
}

class Tear {
    PVector pos;
    float speed = 2;
    Tear(float x, float y) {
        pos = new PVector(x, y);
    }
    void update() {
        pos.y += speed;
    }
    void display() {
        fill(100, 149, 237, 180);
        noStroke();
        ellipse(pos.x, pos.y, 6, 10);
    }
    boolean isGone() {
        return pos.y > height;
    }
}

void drawTears(float x, float y) {
    if(random(1) < 0.3) {
        tears.add(new Tear(x + random(-5, 5), y));
    }
    for(int i = tears.size()-1; i >= 0; i--) {
        Tear t = tears.get(i);
        t.update();
        t.display();
        if(t.isGone()) {
            tears.remove(i);
        }
    }
}

// PERUBAHAN TOTAL: Logika ekspresi dibalik. Senyum jadi sedih, sedih jadi senyum.
void drawFace(String expression, boolean isFemale, float headSize) {
    noStroke();
    fill(0);
    
    float eyeY = -headSize * 0.15;
    float eyeXOffset = headSize * 0.2;
    float eyeSize = headSize * 0.1;
    float mouthY = -headSize * -0.1;

    // Mata
    if (isBlinking) {
        stroke(0);
        strokeWeight(2);
        line(-eyeXOffset, eyeY, -eyeXOffset + 6, eyeY);
        line(eyeXOffset, eyeY, eyeXOffset - 6, eyeY);
        noStroke();
    } else {
        ellipse(-eyeXOffset, eyeY, eyeSize, eyeSize); // Mata kiri
        ellipse(eyeXOffset, eyeY, eyeSize, eyeSize);  // Mata kanan
    }

    // Alis dan Mulut berdasarkan ekspresi
    stroke(0);
    strokeWeight(2);
    float browY = eyeY - headSize * 0.15;
    float browXOffset = headSize * 0.22;

    switch(expression) {
        case "sad":
        case "despair":
            // DIBALIK: Ekspresi yang tadinya sedih, sekarang menjadi SENYUM :)
            line(browXOffset, browY, browXOffset - 8, browY - 2); // Alis naik/normal
            line(-browXOffset, browY, -browXOffset + 8, browY - 2);
            noFill();
            arc(0, mouthY, 15, 12, PI, TWO_PI); // Mulut tersenyum
            break;
            
        default: // Semua ekspresi lain (normal, happy, vowing, dll)
            // DIBALIK: Ekspresi yang tadinya senang, sekarang menjadi SEDIH :(
            line(browXOffset, browY - 2, browXOffset - 8, browY); // Alis sedih
            line(-browXOffset, browY - 2, -browXOffset + 8, browY);
            noFill();
            if (isTalking) { // Jika bicara, mulut tetap terbuka tapi dengan bentuk sedih
                arc(0, mouthY + 5, 12, 10, 0, PI);
            } else {
                arc(0, mouthY + 5, 15, 10, 0, PI); // Mulut melengkung ke bawah
            }
            break;
    }
}


void drawBataraGuru(float x, float y, float scale, boolean gesturing) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Kaki
    fill(139, 69, 19);
    rect(-30, 80, 20, 50);
    rect(10, 80, 20, 50);

    // Tubuh
    fill(139, 69, 19); // Jubah coklat
    rect(-40, -100, 80, 180, 15);
    fill(255, 140, 0); // Selempang
    rect(-45, -80, 90, 30);

    // Lengan
    fill(222, 184, 135);
    stroke(40); strokeWeight(4);
    rect(-55, -60, 20, 80, 5);
    if(gesturing) {
        rect(35, -60, 70, 20, 5);
    } else {
        rect(35, -60, 20, 80, 5);
    }

    // Kepala
    float headY = -130;
    float headSize = 80;
    fill(222, 184, 135);
    ellipse(0, headY, headSize, headSize);
    fill(255, 215, 0);
    noStroke();
    beginShape();
    vertex(-40, headY);
    bezierVertex(-50, headY - 50, 50, headY - 50, 40, headY);
    endShape(CLOSE);
    fill(245, 245, 245);
    beginShape(); 
    vertex(0, -90);
    bezierVertex(-30, -90, -20, -50, 0, -60);
    bezierVertex(20, -50, 30, -90, 0, -90);
    endShape();

    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", false, headSize);
    popMatrix();
    
    popMatrix();
}

void drawAdvisor(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Kaki
    fill(245, 245, 245);
    rect(-30, 80, 20, 50);
    rect(10, 80, 20, 50);
    
    // Tubuh
    fill(245, 245, 245);
    rect(-40, -100, 80, 180, 15);
    fill(222, 184, 135);
    stroke(40); strokeWeight(4);
    rect(-55, -60, 20, 80, 5);
    rect(35, -60, 20, 80, 5);

    // Kepala
    float headY = -130;
    float headSize = 80;
    fill(222, 184, 135);
    ellipse(0, headY, headSize, headSize);
    fill(211, 211, 211);
    noStroke();
    ellipse(0, headY - 10, 90, 40);

    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", false, headSize);
    popMatrix();

    popMatrix();
}

void drawBataraGuruLolo(float x, float y, float scale, String state) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    if (state.equals("flying")) {
        noStroke();
        fill(255, 255, 224, auraAlpha);
        ellipse(0, 0, 150, 250);
    }
    
    stroke(40); strokeWeight(4);

    float walkCycle = 0;
    if(state.equals("walking")) {
        walkCycle = sin(millis() * 0.01) * 20;
    }

    // Kaki
    fill(85, 50, 10);
    pushMatrix(); translate(15, 65); rotate(radians(-walkCycle)); rect(-10, -35, 20, 70); popMatrix();
    pushMatrix(); translate(-15, 65); rotate(radians(walkCycle)); rect(-10, -35, 20, 70); popMatrix();

    // Tubuh
    fill(128, 0, 0); // Merah tua
    rect(-30, -70, 60, 100, 10);
    
    // Lengan
    fill(210, 180, 140);
    pushMatrix(); translate(-38, -25); rotate(radians(-walkCycle * 1.2)); rect(-7.5, -35, 15, 70, 5); popMatrix();
    pushMatrix(); translate(38, -25); rotate(radians(walkCycle * 1.2)); rect(-7.5, -35, 15, 70, 5); popMatrix();
    
    // Kepala
    float headY = -100;
    float headSize = 70;
    fill(210, 180, 140);
    ellipse(0, headY, headSize, headSize);
    fill(50, 30, 10);
    noStroke();
    beginShape();
    vertex(-headSize/2, headY);
    bezierVertex(-headSize*0.6, headY-headSize*0.6, headSize*0.6, headY-headSize*0.6, headSize/2, headY);
    endShape(CLOSE);
    
    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace(state, false, headSize);
    popMatrix();
    
    popMatrix();
}

void drawBataraGuruLoloLanding(float x, float y, float progress) {
    float yOffset = lerp(y - 100, y, progress);
    float rotation = lerp(-0.2, 0, progress);
    
    pushMatrix();
    translate(x, yOffset);
    rotate(rotation);
    drawBataraGuruLolo(0, 0, 1.1, "normal");
    popMatrix();
}

void drawFemaleCharacter(float x, float y, float scale, color sarongColor) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    stroke(40); strokeWeight(4);

    // Tubuh
    fill(255, 215, 0); // Baju Bodo Kuning
    rect(-40, -70, 80, 80, 10); 
    fill(sarongColor); // Sarung dengan warna spesifik karakter
    rect(-30, 10, 60, 90);

    // Lengan
    fill(222, 184, 135);
    rect(-55, -60, 15, 70, 5);
    rect(40, -60, 15, 70, 5);

    // Kepala
    float headY = -100;
    float headSize = 70;
    fill(222, 184, 135);
    ellipse(0, headY, headSize, headSize);
    
    // Hiasan kepala
    float ornamentY = headY - (headSize * 0.45);
    fill(255, 105, 180); // Pink
    ellipse(-15, ornamentY, 20, 20); // Kiri
    ellipse(15, ornamentY, 20, 20);  // Kanan
    fill(255, 255, 0); // Kuning
    ellipse(0, ornamentY - 3, 22, 22);   // Tengah
    
    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", true, headSize);
    popMatrix();

    popMatrix();
}

void drawWeNyiliTimo(float x, float y, float scale) {
    drawFemaleCharacter(x, y, scale, color(189, 183, 107)); // Sarung Hijau Zaitun
}

void drawWeTenriabengAdult(float x, float y, float scale) {
    drawFemaleCharacter(x, y, scale, color(205, 92, 92)); // Sarung Merah India
}

void drawWeCudaiq(float x, float y, float scale) {
    drawFemaleCharacter(x, y, scale, color(70, 130, 180)); // Sarung Biru Baja
}

void drawFamilyTree(float x, float y, long elapsedTime) {
    float progress = map(elapsedTime, 0, 12000, 0, 1);
    stroke(139, 69, 19);
    
    if (progress > 0.1) {
        float branchLength = lerp(0, 100, (progress - 0.1) / 0.2);
        strokeWeight(10);
        line(x - 100, y - 450, x - 100 + branchLength, y - 450);
        line(x + 100, y - 450, x + 100 - branchLength, y - 450);
        if (progress > 0.2) {
            drawCharacterPortrait(x - 200, y - 450, "Batara Guru");
            drawCharacterPortrait(x + 200, y - 450, "We Nyili Timo");
        }
    }
    
    if (progress > 0.3) {
        float branchLength = lerp(0, 100, (progress - 0.3) / 0.2);
        strokeWeight(10);
        line(x, y - 450, x, y - 450 + branchLength);
        if (progress > 0.4) {
            drawCharacterPortrait(x, y - 350, "Batara Lattu");
        }
    }

    if (progress > 0.5) {
        float branchLength = lerp(0, 100, (progress - 0.5) / 0.2);
        strokeWeight(8);
        line(x, y - 350, x - branchLength, y - 250);
        line(x, y - 350, x + branchLength, y - 250);
        if (progress > 0.7) {
            drawCharacterPortrait(x - 150, y - 200, "Sawerigading");
            drawCharacterPortrait(x + 150, y - 200, "We Tenriabéng");
        }
    }
}

void drawCharacterPortrait(float x, float y, String name) {
    noStroke();
    fill(210, 180, 140, 200);
    ellipse(x, y, 80, 80);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(name, x, y + 50);
}

void drawSawerigadingChild(float x, float y, float scale, String state) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    stroke(40);
    strokeWeight(4);

    // Kaki
    fill(85, 50, 10);
    rect(-25, 30, 20, 70);
    rect(5, 30, 20, 70);

    // Tubuh & Baju Biru
    fill(0, 70, 150);
    rect(-30, -70, 60, 100, 10);

    // Lengan
    fill(210, 180, 140);
    if (state.equals("surprised")) {
        // Tangan terangkat ke arah kotak
        rect(-45, -50, 15, 40, 5);
        rect(30, -50, 15, 40, 5);
    } else {
        // Tangan di samping
        rect(-45, -60, 15, 70, 5);
        rect(30, -60, 15, 70, 5);
    }

    // Kepala
    float headY = -100;
    float headSize = 70;
    fill(210, 180, 140);
    ellipse(0, headY, headSize, headSize);

    // Rambut
    fill(50, 30, 10);
    noStroke();
    beginShape();
    vertex(-headSize/2, headY);
    bezierVertex(-headSize*0.6, headY-headSize*0.6, headSize*0.6, headY-headSize*0.6, headSize/2, headY);
    endShape(CLOSE);

    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace(state, false, headSize);
    popMatrix();

    popMatrix();
}

void drawWeTenriabengChild(float x, float y, float scale) {
    drawWeNyiliTimo(x, y, scale); // Menggunakan base yg sama, tapi lebih kecil
}

void drawSawerigadingAdult(float x, float y, float scale, String state) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    
    stroke(40);
    strokeWeight(4);

    float walkCycle = 0;
    if (state.equals("walking")) {
        walkCycle = sin(millis() * 0.01) * 20;
    }

    // Kaki & Sarung
    fill(85, 50, 10);
    rect(-25 + walkCycle, 30, 20, 70);
    rect(5 - walkCycle, 30, 20, 70);

    // Tubuh & Baju (WARNA BARU: BIRU)
    fill(0, 70, 150); // Biru Tua Gagah
    rect(-30, -70, 60, 100, 10);
    
    // Lengan berdasarkan state
    fill(210, 180, 140);
    stroke(40);
    switch(state) {
        case "despair":
            rect(-15, -80, 15, 40, 5); // Tangan di wajah
            rect(0, -80, 15, 40, 5);
            if(isCrying) drawTears(0, -90); // Air mata tetap ada untuk efek ironis
            break;
        case "idea":
            rect(-45, -60, 15, 70, 5); 
            rect(30, -80, 15, 70, 5); 
            break;
        case "vowing":
            rect(-20, -60, 15, 50, 5); // Tangan menyembah
            rect(5, -60, 15, 50, 5);
            break;
        case "chopping":
            rect(-45, -60, 15, 70, 5); // Tangan kiri diam
            float swingAngle = map(sin(millis() * 0.01), -1, 1, -PI / 6, PI / 3);
            pushMatrix();
            rotate(swingAngle);
            rect(20, -50, 80, 20, 5); // Lengan kanan & Kapak
            popMatrix();
            break;
        case "walking_back":
            rect(-45, -60, 15, 70, 5);
            rect(30, -60, 15, 70, 5);
            break;
        case "writing":
            rect(-45, -60, 15, 70, 5); 
            rect(30, -60, 15, 40, 5); 
            break;
        default: // normal, happy, sad
            rect(-45 - walkCycle * 0.8, -60, 15, 70, 5);
            rect(30 + walkCycle * 0.8, -60, 15, 70, 5);
            break;
    }
    
    float headY = -100;
    float headSize = 70;

    if (state.equals("walking_back")) {
        // Gambar dari belakang
        fill(0, 70, 150); // Baju Biru
        rect(-30, -70, 60, 100, 10);
        fill(50, 30, 10); // Rambut
        ellipse(0, headY, headSize, headSize);
    } else {
        // Kepala
        fill(210, 180, 140);
        ellipse(0, headY, headSize, headSize);

        // Rambut
        fill(50, 30, 10);
        noStroke();
        beginShape();
        vertex(-headSize/2, headY);
        bezierVertex(-headSize*0.6, headY-headSize*0.6, headSize*0.6, headY-headSize*0.6, headSize/2, headY);
        endShape(CLOSE);
        
        // Wajah Ekspresif
        pushMatrix();
        translate(0, headY);
        drawFace(state, false, headSize);
        popMatrix();
    }

    popMatrix();
}

void drawBataraLattu(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Singgasana
    fill(139, 69, 19);
    rect(-60, -80, 120, 180, 10);
    
    // Kaki
    fill(47, 79, 79);
    rect(-30, 100, 20, 40);
    rect(10, 100, 20, 40);

    // Tubuh
    fill(47, 79, 79); // Hijau tua
    rect(-40, -100, 80, 150, 15);
    
    // Lengan
    fill(222, 184, 135);
    stroke(40);
    strokeWeight(4);
    rect(-55, -60, 20, 80, 5);
    rect(35, -60, 20, 80, 5);
    
    // Kepala
    float headY = -130;
    float headSize = 80;
    fill(222, 184, 135);
    ellipse(0, headY, headSize, headSize);
    
    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", false, headSize);
    popMatrix();

    popMatrix();
}

void drawCraftsman(float x, float y, float scale, String state) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    stroke(40);
    strokeWeight(4);

    // Kaki
    fill(85, 50, 10);
    rect(-25, 30, 20, 70);
    rect(5, 30, 20, 70);

    // Tubuh & Baju Coklat Sederhana
    fill(160, 82, 45); // Sienna brown
    rect(-30, -70, 60, 100, 10);

    // Lengan
    fill(210, 180, 140);
    rect(-45, -60, 15, 70, 5); // Tangan kiri diam
    if (state.equals("working")) {
      float swingAngle = map(sin(millis() * 0.008 + x), -1, 1, -PI/8, PI/8);
      pushMatrix();
      translate(30, -40);
      rotate(swingAngle);
      rect(0, 0, 60, 15, 5); // Lengan kanan & palu
      popMatrix();
    } else {
      rect(30, -60, 15, 70, 5);
    }

    // Kepala
    float headY = -100;
    float headSize = 70;
    fill(210, 180, 140);
    ellipse(0, headY, headSize, headSize);

    // Rambut
    fill(50, 30, 10);
    noStroke();
    arc(0, headY, headSize, headSize, PI, TWO_PI);

    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", false, headSize);
    popMatrix();

    popMatrix();
}

void drawBissu(float x, float y, float scale) {
    pushMatrix();
    translate(x,y);
    scale(scale);

    // Kaki
    fill(245, 245, 245);
    rect(-20, 50, 15, 50);
    rect(5, 50, 15, 50);

    // Tubuh
    fill(255);
    rect(-30, -70, 60, 120, 10);
    
    // Lengan
    fill(222, 184, 135);
    stroke(40); strokeWeight(4);
    rect(-45, -60, 15, 70, 5);
    rect(30, -60, 15, 70, 5);

    // Kepala
    float headY = -100;
    float headSize = 70;
    fill(222, 184, 135);
    ellipse(0, headY, headSize, headSize);
    fill(50, 30, 10);
    arc(0, headY, headSize, headSize, PI, TWO_PI);
    
    // Wajah
    pushMatrix();
    translate(0, headY);
    drawFace("normal", false, headSize);
    popMatrix();

    popMatrix();
}

void drawEnemyWarrior(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    // Base character
    drawBataraGuruLolo(0,0,1.0,"vowing");
    // Armor
    fill(105,105,105, 150);
    rect(-35, -70, 70, 100, 10);
    popMatrix();
}

void drawWeCudaiqHoldingBaby(float x, float y, float scale) {
    drawWeCudaiq(x, y, scale);
    
    pushMatrix();
    translate(x, y);
    scale(scale);
    
    // Bayi
    fill(245, 222, 179); // Kain bedong
    ellipse(0, 0, 50, 70);
    fill(222, 184, 135); // Kepala bayi
    ellipse(0, -20, 30, 30);
    
    popMatrix();
}

void drawLaGaligoToddler(float x, float y, float scale) {
    pushMatrix();
    translate(x,y);
    scale(scale);
    drawBataraGuruLolo(0,0,1.0,"normal");
    // Timpa warna baju
    fill(34, 139, 34); // Hijau
    rect(-30, -70, 60, 100, 10);
    popMatrix();
}

void drawLaGaligoAdult(float x, float y, float scale, String state) {
    pushMatrix();
    translate(x,y);
    scale(scale);
    drawSawerigadingAdult(0,0,1.0, state);
    // Timpa warna baju
    fill(0, 100, 100); // Teal untuk La Galigo
    rect(-30, -70, 60, 100, 10);
    popMatrix();
}

void drawElder(float x, float y, float scale) {
    drawAdvisor(x, y, scale);
}

void drawDetailedShip(float x, float y, float scale, boolean unfurledSail) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  
  // Lambung kapal Pinisi
  fill(139, 69, 19);
  stroke(87, 58, 29);
  strokeWeight(5);
  beginShape();
  vertex(-200, 50);
  bezierVertex(-150, 100, 150, 100, 200, 50);
  vertex(180, 20);
  vertex(-180, 20);
  endShape(CLOSE);

  // Dek dan pagar
  fill(160, 82, 45);
  rect(-180, 0, 360, 20);
  for(int i = -170; i < 170; i+=20) {
      rect(i, -20, 5, 20);
  }

  // Tiang utama
  fill(85, 50, 10);
  rect(-10, -200, 20, 200);

  // Layar Segitiga Tunggal
  fill(245, 245, 245);
  noStroke();
  if (unfurledSail) {
    float sailWave = sin(millis() * 0.002) * 15;
    beginShape();
    vertex(5, -190); // Puncak tiang
    vertex(5, -10);   // Bawah tiang (dinaikkan)
    vertex(150 + sailWave, -10); // Ujung layar (dinaikkan)
    endShape(CLOSE);
  } else {
    // Layar tergulung di tiang
    rect(-15, -150, 10, 140, 5); 
  }
  
  popMatrix();
}

// --- FUNGSI GAMBAR LINGKUNGAN ---

void drawGround(float y, color c) {
    fill(c);
    noStroke();
    rect(0, y, width, height - y);
}

void drawSmoothClouds(float xOffset, float y, int numClouds, boolean isBase) {
  noStroke();
  for (int i = 0; i < numClouds; i++) {
    float cloudX = (xOffset + i * 250 - cloudOffset * 20000) % (width + 400) - 200;
    float cloudY = y + noise(noiseSeed + i, cloudOffset) * 50 - 25;
    float cloudW = 200 + noise(noiseSeed + i + 10) * 150;
    float cloudH = 60 + noise(noiseSeed + i + 20) * 40;
    if (isBase) {
        cloudW *= 1.5;
        cloudH *= 1.5;
    }
    fill(255, 250, 250, 200);
    ellipse(cloudX, cloudY, cloudW, cloudH);
    ellipse(cloudX + 50, cloudY + 10, cloudW * 0.7, cloudH * 0.8);
    ellipse(cloudX - 40, cloudY + 5, cloudW * 0.6, cloudH * 0.7);
  }
}

void drawDetailedPalace(float x, float y, float scale, float alpha) {
    pushMatrix();
    translate(x,y);
    scale(scale);
    
    color baseColor = color(218, 165, 32, alpha);
    color detailColor = color(139, 69, 19, alpha);
    color strokeColor = color(87, 58, 29, alpha);

    fill(baseColor);
    stroke(strokeColor);
    strokeWeight(4);
    
    // Bangunan utama
    rect(-150, 0, 300, 150, 10);
    
    // Atap bertingkat
    fill(detailColor);
    for(int i=0; i<3; i++) {
        float offset = i * 30;
        triangle(-180 + offset, -offset, 180 - offset, -offset, 0, -100 - offset*1.5);
    }
    
    // Pilar
    fill(baseColor);
    for(int i=-2; i<=2; i++) {
        if (i==0) continue;
        rect(i*60 - 10, 50, 20, 100);
    }
    
    popMatrix();
}

void drawDetailedTree(float x, float y, float scale) {
    pushMatrix();
    translate(x,y);
    scale(scale);
    // Batang
    fill(139, 69, 19);  
    noStroke();
    rect(-20, 0, 40, -100);
    // Dedaunan
    fill(34, 139, 34);  
    ellipse(0, -150, 150, 150);
    ellipse(-40, -140, 80, 80);
    ellipse(40, -140, 80, 80);
    popMatrix();
}

void drawDetailedMountain(float x, float y, float w, float h) {
    fill(119, 136, 153); // Abu-abu
    noStroke();
    beginShape();
    vertex(x - w/2, y);
    bezierVertex(x - w/4, y-h*1.2, x + w/4, y-h*1.2, x + w/2, y);
    endShape();
}

void drawDetailedRiver(float x, float y, float w, float h) {
    fill(100, 149, 237);
    noStroke();
    rect(x, y, w, h);
}

void drawDetailedGrass(float y, float h, float spacing) {
    fill(154, 205, 50);
    noStroke();
    for(float x = 0; x < width; x+=spacing) {
        triangle(x, y, x+spacing, y, x+spacing/2, y-h-random(10));
    }
}

void drawDetailedFlower(float x, float y, float size) {
    pushMatrix();
    translate(x,y);
    // Batang
    stroke(34, 139, 34);
    strokeWeight(4);
    line(0, 0, 0, -50);
    // Bunga
    noStroke();
    fill(255, 105, 180);
    for(int i=0; i<5; i++) {
        ellipse(cos(i*TWO_PI/5)*size*0.4, sin(i*TWO_PI/5)*size*0.4 -50, size*0.6, size*0.6);
    }
    fill(255, 255, 0);
    ellipse(0, -50, size*0.4, size*0.4);
    popMatrix();
}

void drawRealisticBird(float x, float y, float size) {
  stroke(50);
  strokeWeight(3);
  noFill();
  float wingFlap = sin(millis() * 0.05 + y) * size * 0.5;
  // Bentuk 'M'
  beginShape();
  vertex(x - size, y + wingFlap);
  vertex(x, y - wingFlap);
  vertex(x + size, y + wingFlap);
  endShape();
}

void drawDetailedWaves(float offset) {
  fill(100, 149, 237, 150);
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for (float x = 0; x <= width; x += 20) {
    float y1 = height * 0.8 + sin((x + offset*100) * 0.01) * 20;
    float y2 = height * 0.85 + cos((x + offset*100) * 0.015) * 15;
    vertex(x, y1);
    vertex(x, y2);
  }
  endShape();
}

void drawPalaceHallBackground() {
  // Dinding
  background(184, 134, 11); // Dinding coklat keemasan
  fill(160, 82, 45, 150);
  for(int i=0; i<5; i++) {
      rect(i * width/4, 0, 20, height * 0.7); // Pilar hanya sampai lantai
  }

  // Lantai
  fill(139, 69, 19); // Coklat kayu gelap untuk lantai
  noStroke();
  rect(0, height * 0.7, width, height * 0.3);
  // Detail papan lantai
  stroke(87, 58, 29, 100);
  for(int i=0; i < 10; i++) {
      line(0, height * 0.7 + i * (height*0.3/10), width, height * 0.7 + i * (height*0.3/10));
  }
}

void drawHeart(float x, float y, float size) {
  fill(255, 20, 147, 200);
  noStroke();
  beginShape();
  vertex(x, y);
  bezierVertex(x, y - size / 2, x - size, y - size / 2, x - size, y);
  bezierVertex(x - size, y + size / 3, x, y + size, x, y + size);
  bezierVertex(x, y + size / 3, x + size, y + size / 3, x + size, y);
  bezierVertex(x + size, y - size / 2, x, y - size / 2, x, y);
  endShape(CLOSE);
}

void drawPalmTree(float x, float y, float scale) {
    pushMatrix();
    translate(x,y);
    scale(scale);
    fill(139, 69, 19); // Batang
    noStroke();
    rect(-15, 0, 30, -150);
    fill(34, 139, 34); // Daun
    for(int i=0; i<6; i++) {
        pushMatrix();
        translate(0, -150);
        rotate(i*PI/3);
        arc(50, 0, 100, 80, -HALF_PI, HALF_PI);
        popMatrix();
    }
    popMatrix();
}

void drawLightning(float x, float y, int segments, float length, float randomness) {
    stroke(255, 255, 0, 200);
    strokeWeight(4);
    float prevX = x;
    float prevY = y;
    for (int i = 0; i < segments; i++) {
        float nextX = prevX + random(-randomness, randomness);
        float nextY = prevY + length;
        line(prevX, prevY, nextX, nextY);
        prevX = nextX;
        prevY = nextY;
    }
}

void drawIdeaIcon(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  // Sinar lampu
  stroke(255, 255, 0, 150);
  strokeWeight(3);
  for(int i=0; i<8; i++) {
    float angle = i * TWO_PI / 8;
    line(0, 0, cos(angle) * 40, sin(angle) * 40);
  }

  // Bohlam
  fill(255, 255, 0); // Kuning
  noStroke();
  ellipse(0, -10, 40, 40); // Bagian bulat
  
  // Fiting lampu
  fill(150); // Abu-abu
  rect(-10, 10, 20, 10);
  
  popMatrix();
}

void drawSubtitle() {
  fill(0, 0, 0, 180);
  noStroke();
  rect(0, height - 100, width, 100);

  fill(255);
  textSize(22);
  textAlign(CENTER, CENTER);
  text(subtitles[currentFrame - 1], width * 0.1, height - 80, width * 0.8, 80);
}
