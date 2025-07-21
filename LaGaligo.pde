// Animasi Epos La Galigo (Frame 1-27) Berwarna Realistis Detail & Bersubtitle
// Dibuat dengan Processing (Java)

// Variabel untuk mengontrol frame dan waktu
int currentFrame = 1;
long frameStartTime;
int frameDuration = 5000; // Durasi setiap frame dalam milidetik (rata-rata 5-6 detik/frame)

// Variabel global untuk mengontrol animasi kedipan mata dan bicara
boolean isBlinking = false;
long lastBlinkTime = 0;
int blinkDuration = 100; // Durasi kedipan mata (ms)
int blinkInterval = 3000; // Interval rata-rata antar kedipan (ms)

boolean isTalking = false;
long lastTalkToggle = 0;
int talkToggleInterval = 200; // Interval perubahan bentuk mulut (ms)

// Variabel untuk animasi Frame 1 (Ledakan Kosmik)
float blackHole1X, blackHole1Y;
float blackHole2X, blackHole2Y;
float blackHoleRadius = 40;
float collisionProgress = 0; // 0.0 - 1.0
float explosionEffectRadius = 0;
int numExplosionParticles = 300;
ExplosionParticle[] explosionParticles = new ExplosionParticle[numExplosionParticles];
boolean explosionStarted = false;

// Variabel untuk animasi Frame 4 (Batara Guru Lolo ri Sérenaé Turun)
float descentY = -200; // Posisi awal di atas layar
float targetDescentY;

// Variabel untuk animasi Frame 5 (Pendaratan Heroik)
float landingProgress = 0; // 0-1 untuk transisi pendaratan

// Variabel untuk animasi Frame 6 (Berjalan Sendirian)
float walkX = -100; // Posisi awal di luar layar kiri

// Variabel untuk animasi Frame 8 (Melihat ke bawah)
float lookDownOffset = 0;

// Variabel untuk animasi Frame 10 (Jatuh cinta)
float heartSize = 0;

// Variabel untuk animasi Frame 13 (Bola bercahaya)
float orbSplitProgress = 0;

// Variabel untuk animasi Frame 17 (Daun jatuh)
ArrayList<Leaf> fallingLeaves;

// Variabel untuk animasi Frame 20 (Pohon menebang)
float treeCrackProgress = 0;

// Variabel untuk animasi Frame 23 (Kapal bergerak)
float shipX = -300;

// Variabel untuk animasi ombak di Frame 23
float waveOffset = 0;

// Subtitles
String[] subtitles = {
  "Sebuah ledakan energi besar dari lingkaran hitam di tengah ruang hampa. Gelombang cahaya mengembang ke segala arah.", // Frame 1
  "Istana langit megah milik Batara Guru melayang di atas awan. Langit tampak tenang.", // Frame 2
  "Batara Guru dan penasihat berdiskusi, kemudian Batara Guru memberi perintah kepada Batara Guru Lolo ri Sérenaé.", // Frame 3 (Gabungan F3 & F4)
  "Batara Guru Lolo ri Sérenaé melayang di langit turun ke bumi. Jubahnya mengembang ke atas.", // Frame 4 (Asli F5)
  "Pendaratan heroik di padang rumput. Lutut kiri dan tangan kiri menyentuh tanah, tangan kanan terbuka ke samping.", // Frame 5 (Asli F6)
  "Tokoh itu berjalan sendirian menyusuri lanskap alam Sulawesi. Gunung, sungai kecil, dan pohon rindang mewarnai perjalanan.", // Frame 6 (Asli F7)
  "Tampilan panorama alam tanpa manusia. Hutan tropis, lereng bukit, dan cakrawala yang terbuka lebar. Burung terbang di kejauhan.", // Frame 7 (Asli F8)
  "Saat melayang, Batara Guru Lolo ri Sérenaé melihat ke bawah dan melihat We Nyili Timo berdiri di bawah hutan terbuka. Ekspresinya sedikit terkejut namun tenang.", // Frame 8 (Gabungan F9 & F10)
  "Batara Guru Lolo ri Sérenaé dan We Nyili Timo berdiri saling berhadapan di tengah padang ilalang yang tenang. Simbol hati kecil terpancar di antara mereka.", // Frame 9 (Asli F11)
  "Gambar silsilah keluarga berbentuk pohon bercabang dari Batara Guru dan We Nyili Timo, menunjukkan beberapa keturunan hingga mencapai Sawerigading.", // Frame 10 (Asli F12)
  "Seorang anak kecil (Sawerigading) mendekati sebuah kotak kayu tua dengan ukiran simbol kuno. Dari dalam kotak, muncul bola bercahaya yang terbelah dua.", // Frame 11 (Gabungan F13 & F14)
  "Frame terbagi dua. Kiri: Sawerigading kecil di padang rumput. Kanan: saudara kembar perempuan (We Tenriabéng) di taman bunga. Garis cahaya memisahkan takdir mereka.", // Frame 12 (Asli F15)
  "Masih terbagi dua. Kiri: Sawerigading dewasa dalam baju perang. Kanan: We Tenriabéng dewasa dalam kebaya bangsawan. Keduanya menatap ke arah tengah dengan kerinduan.", // Frame 13 (Asli F16)
  "Sawerigading dan We Tenriabéng bertemu tanpa sadar bahwa mereka adalah saudara. Mereka duduk di bangku kayu ukir, berbincang dekat.", // Frame 14 (Gabungan F17 & F18)
  "Sawerigading tampak dari belakang berjalan meninggalkan taman, menuju istana di kejauhan. Langkahnya berat.", // Frame 15 (Asli F19)
  "Di dalam aula istana, Batara Lattu duduk di singgasana, berbicara dengan Sawerigading yang berdiri di depannya. Batara Lattu menunjuk ke arah luar.", // Frame 16 (Asli F20)
  "Sawerigading duduk di bawah pohon besar dengan kepala tertunduk dan wajah ditutupi tangan. Tiba-tiba, ia mengangkat kepala dan menunjuk ke atas dengan semangat baru.", // Frame 17 (Gabungan F21 & F22)
  "Di balkon istana pada malam hari, Sawerigading berdiri gagah, tangan kanan ke dada bersumpah di bawah cahaya bulan.", // Frame 18 (Asli F23)
  "Di hutan, Sawerigading menebang pohon besar dengan kapak. Kayu mulai retak dan pohon roboh dengan keras.", // Frame 19 (Gabungan F24 & F25)
  "Para pengrajin dan bissu mulai membentuk kayu menjadi kapal besar. Alat-alat sederhana berserakan, suasana kerja kolaboratif.", // Frame 20 (Asli F26)
  "Kapal megah selesai dibangun, berdiri di tepi sungai. Ukiran kepala naga di haluan. Bissu memberkati kapal dengan asap dupa.", // Frame 21 (Asli F27)
  "Sawerigading berdiri di atas kapal, memandang ke laut lepas. Angin meniup kainnya. Ombak bergulung dan burung camar terbang.", // Frame 22 (Asli F28)
  "Pertarungan laut antara Sawerigading dan musuh bersenjata tombak. Kapal bergoyang hebat, petir menyambar dari langit.", // Frame 23 (Asli F29)
  "Kapal Sawerigading tiba di sebuah pulau tropis. Gunung menjulang di kejauhan, pohon kelapa berjajar di pantai. Ombak tenang menyambut kapal.", // Frame 24 (Asli F30)
  "Sawerigading bertemu seorang wanita (We Cudaiq) yang mirip saudara kembarnya. Mereka berdiri di bawah pohon berbunga, saling menatap penuh kehangatan dan tersenyum.", // Frame 25 (Gabungan F31 & F32)
  "Di dalam rumah kayu sederhana, bayi La Galigo lahir dan digendong oleh sang ibu. Sawerigading berdiri di sisi mereka dengan wajah lembut.", // Frame 26 (Asli F33)
  "Potret keluarga: Sawerigading, istrinya, dan La Galigo balita duduk bersama, tersenyum ke arah depan. Latar berupa hiasan dinding kerajaan." // Frame 27 (Asli F34)
};


void setup() {
  size(1200, 675); // Ukuran kanvas landscape (16:9)
  frameStartTime = millis(); // Inisialisasi waktu mulai frame pertama
  targetDescentY = height * 0.6; // Posisi berhenti untuk Batara Guru Lolo ri Sérenaé

  // FIX: Inisialisasi ArrayList 'fallingLeaves' SEBELUM digunakan.
  // Ini mencegah NullPointerException saat resetFrameAnimations() dipanggil.
  fallingLeaves = new ArrayList<Leaf>();

  resetFrameAnimations(); // Panggil resetFrameAnimations di setup
}

void draw() {
  long elapsedTime = millis() - frameStartTime;

  // Update blinking and talking states
  if (millis() - lastBlinkTime > blinkInterval + random(-1000, 1000)) {
    isBlinking = true;
    lastBlinkTime = millis();
  }
  if (isBlinking && millis() - lastBlinkTime > blinkDuration) {
    isBlinking = false;
  }

  // Simple talking animation toggle
  if (millis() - lastTalkToggle > talkToggleInterval) {
    isTalking = !isTalking;
    lastTalkToggle = millis();
  }


  // Cek apakah sudah waktunya berpindah ke frame berikutnya
  if (elapsedTime > frameDuration) {
    currentFrame++;
    frameStartTime = millis(); // Reset waktu mulai untuk frame baru
    elapsedTime = 0; // Reset elapsed time for the new frame

    // Jika semua frame sudah selesai, kembali ke frame 1
    if (currentFrame > subtitles.length) { // Menggunakan panjang array subtitle sebagai batas frame
      currentFrame = 1;
    }

    // Reset animasi spesifik untuk frame baru
    resetFrameAnimations();
  }

  // Gambar berdasarkan frame saat ini
  switch (currentFrame) {
    case 1:
      drawFrame1(elapsedTime);
      break;
    case 2:
      drawFrame2(elapsedTime);
      break;
    case 3: // Gabungan F3 & F4
      drawFrame3(elapsedTime);
      break;
    case 4: // Asli F5
      drawFrame4(elapsedTime);
      break;
    case 5: // Asli F6
      drawFrame5(elapsedTime);
      break;
    case 6: // Asli F7
      drawFrame6(elapsedTime);
      break;
    case 7: // Gabungan F7 & F8
      drawFrame7(elapsedTime);
      break;
    case 8: // Gabungan F9 & F10
      drawFrame8(elapsedTime);
      break;
    case 9: // Asli F11
      drawFrame9(elapsedTime);
      break;
    case 10: // Asli F12
      drawFrame10(elapsedTime);
      break;
    case 11: // Gabungan F13 & F14
      drawFrame11(elapsedTime);
      break;
    case 12: // Asli F15
      drawFrame12(elapsedTime);
      break;
    case 13: // Asli F16
      drawFrame13(elapsedTime);
      break;
    case 14: // Gabungan F17 & F18
      drawFrame14(elapsedTime);
      break;
    case 15: // Asli F19
      drawFrame15(elapsedTime);
      break;
    case 16: // Asli F20
      drawFrame16(elapsedTime);
      break;
    case 17: // Gabungan F21 & F22
      drawFrame17(elapsedTime);
      break;
    case 18: // Asli F23
      drawFrame18(elapsedTime);
      break;
    case 19: // Gabungan F24 & F25
      drawFrame19(elapsedTime);
      break;
    case 20: // Asli F26
      drawFrame20(elapsedTime);
      break;
    case 21: // Asli F27
      drawFrame21(elapsedTime);
      break;
    case 22: // Asli F28
      drawFrame22(elapsedTime);
      break;
    case 23: // Asli F29
      drawFrame23(elapsedTime);
      break;
    case 24: // Asli F30
      drawFrame24(elapsedTime);
      break;
    case 25: // Gabungan F31 & F32
      drawFrame25(elapsedTime);
      break;
    case 26: // Asli F33
      drawFrame26(elapsedTime);
      break;
    case 27: // Asli F34
      drawFrame27(elapsedTime);
      break;
  }

  // Draw subtitle
  drawSubtitle();
}

void resetFrameAnimations() {
  // Reset all animation variables for the new frame
  // This ensures animations restart correctly for each frame transition
  explosionEffectRadius = 0;
  explosionStarted = false;
  collisionProgress = 0;
  // Initialize particles with valid data
  for (int i = 0; i < numExplosionParticles; i++) {
    explosionParticles[i] = new ExplosionParticle(width / 2, height / 2); // Pass center coordinates
  }

  descentY = -200;
  landingProgress = 0;
  walkX = -100;
  lookDownOffset = 0;
  heartSize = 0;
  orbSplitProgress = 0;
  fallingLeaves.clear();
  treeCrackProgress = 0;
  shipX = -300;
  waveOffset = 0;
}

// --- Fungsi untuk Menggambar Setiap Frame ---

void drawFrame1(long elapsedTime) {
  background(0); // Latar belakang hitam pekat

  float collisionTime = frameDuration * 0.5; // Waktu tabrakan (50% durasi frame)
  float explosionStartTime = frameDuration * 0.5; // Waktu mulai ledakan

  if (elapsedTime < collisionTime) {
    // Fase 1: Dua lingkaran bergerak mendekat
    collisionProgress = map(elapsedTime, 0, collisionTime, 0, 1);
    float currentX1 = map(collisionProgress, 0, 1, width * 0.25, width / 2);
    float currentX2 = map(collisionProgress, 0, 1, width * 0.75, width / 2);

    noStroke();
    fill(0); // Lingkaran hitam
    ellipse(currentX1, height / 2, blackHoleRadius * 2, blackHoleRadius * 2);
    ellipse(currentX2, height / 2, blackHoleRadius * 2, blackHoleRadius * 2);

    // Efek cahaya di sekitar lingkaran saat mendekat
    fill(255, 255, 200, 50);
    ellipse(currentX1, height / 2, blackHoleRadius * 2.5, blackHoleRadius * 2.5);
    ellipse(currentX2, height / 2, blackHoleRadius * 2.5, blackHoleRadius * 2.5);
  } else {
    // Fase 2: Ledakan dan transisi
    if (!explosionStarted) {
      explosionStarted = true;
      // Inisialisasi partikel ledakan dari tengah
      for (int i = 0; i < numExplosionParticles; i++) {
        explosionParticles[i] = new ExplosionParticle(width / 2, height / 2);
      }
    }

    float explosionElapsedTime = elapsedTime - explosionStartTime;
    explosionEffectRadius = map(explosionElapsedTime, 0, frameDuration - explosionStartTime, 0, max(width, height) * 1.5);

    // Gambar partikel ledakan
    for (int i = 0; i < numExplosionParticles; i++) {
      explosionParticles[i].update();
      explosionParticles[i].display();
    }

    // Efek gelombang energi dari pusat ledakan
    for (int i = 0; i < 5; i++) {
      float currentWaveRadius = explosionEffectRadius * (0.2 + i * 0.15);
      float alpha = map(currentWaveRadius, 0, max(width, height) * 1.5, 200, 0);
      stroke(255, 255, 200, alpha);
      strokeWeight(2);
      noFill();
      ellipse(width / 2, height / 2, currentWaveRadius, currentWaveRadius);
    }
  }
}

class ExplosionParticle {
  PVector pos;
  PVector vel;
  float life;
  color particleColor;

  // Constructor default (tetap ada, tapi tidak digunakan untuk inisialisasi utama)
  ExplosionParticle() {
    // Default values, will be re-initialized if used without arguments
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    life = 0;
    particleColor = color(0);
  }

  ExplosionParticle(float startX, float startY) {
    pos = new PVector(startX, startY);
    float angle = random(TWO_PI);
    float speed = random(1, 8); // Kecepatan awal partikel
    vel = PVector.fromAngle(angle).mult(speed);
    life = 255;
    particleColor = color(random(200, 255), random(200, 255), random(150, 200)); // Warna cahaya
  }

  void update() {
    pos.add(vel);
    vel.mult(0.97); // Perlambatan agar menyebar
    life -= 5; // Mengurangi masa hidup lebih cepat
  }

  void display() {
    noStroke();
    fill(particleColor, life);
    ellipse(pos.x, pos.y, 4, 4);
  }
}

void drawFrame2(long elapsedTime) {
  // Latar belakang langit tenang
  background(100, 150, 200); // Biru langit
  noStroke();

  // Awan realistis dan banyak
  drawRealisticClouds(width * 0.2, height * 0.7, 350, 120);
  drawRealisticClouds(width * 0.8, height * 0.6, 400, 150);
  drawRealisticClouds(width * 0.5, height * 0.8, 450, 180);
  drawRealisticClouds(width * 0.1, height * 0.4, 250, 100);
  drawRealisticClouds(width * 0.9, height * 0.3, 300, 110);


  // Istana langit megah milik Batara Guru
  float palaceX = width / 2;
  float palaceY = height * 0.4;
  float palaceWidth = 300;
  float palaceHeight = 200;

  // Animasi melayang (naik turun perlahan)
  float floatOffset = sin(millis() * 0.001) * 10; // Offset naik turun
  palaceY += floatOffset;

  // Dasar istana (melayang di atas awan)
  fill(180, 140, 80); // Coklat keemasan
  rect(palaceX - palaceWidth / 2, palaceY, palaceWidth, palaceHeight, 10); // Rounded corners

  // Atap lengkung bertingkat (mirip rumah adat Bugis)
  fill(120, 80, 40); // Coklat lebih gelap
  // Atap paling bawah
  beginShape();
  vertex(palaceX - palaceWidth / 2 - 20, palaceY);
  vertex(palaceX + palaceWidth / 2 + 20, palaceY);
  vertex(palaceX + palaceWidth / 2 + 10, palaceY - 30);
  vertex(palaceX - palaceWidth / 2 - 10, palaceY - 30);
  endShape(CLOSE);

  // Atap tengah
  beginShape();
  vertex(palaceX - palaceWidth / 2 + 10, palaceY - 30);
  vertex(palaceX + palaceWidth / 2 - 10, palaceY - 30);
  vertex(palaceX + palaceWidth / 2 - 20, palaceY - 60);
  vertex(palaceX - palaceWidth / 2 + 20, palaceY - 60);
  endShape(CLOSE);

  // Atap paling atas
  beginShape();
  vertex(palaceX - 50, palaceY - 60);
  vertex(palaceX + 50, palaceY - 60);
  vertex(palaceX + 30, palaceY - 90);
  vertex(palaceX - 30, palaceY - 90);
  endShape(CLOSE);

  // Tiang tinggi
  fill(150, 110, 60); // Coklat
  rect(palaceX - palaceWidth / 2 + 30, palaceY + 50, 20, palaceHeight - 50);
  rect(palaceX + palaceWidth / 2 - 50, palaceY + 50, 20, palaceHeight - 50);

  // Detail jendela/pintu
  fill(50, 30, 10); // Coklat gelap
  rect(palaceX - 30, palaceY + 70, 60, 80);
}

void drawRealisticClouds(float x, float y, float w, float h) {
  fill(255, 255, 255, 220); // Putih sedikit transparan
  noStroke();
  ellipse(x, y, w, h);
  ellipse(x - w * 0.3, y + h * 0.1, w * 0.7, h * 0.8);
  ellipse(x + w * 0.3, y + h * 0.1, w * 0.7, h * 0.8);
  ellipse(x - w * 0.1, y - h * 0.2, w * 0.6, h * 0.7);
  ellipse(x + w * 0.1, y - h * 0.2, w * 0.6, h * 0.7);
}

void drawFrame3(long elapsedTime) {
  background(150, 100, 50); // Latar belakang aula istana (coklat keemasan)

  // Latar belakang berupa pilar
  fill(200, 160, 100); // Pilar emas/krem
  rect(width * 0.1, 0, 80, height);
  rect(width * 0.9 - 80, 0, 80, height);
  rect(width * 0.35, 0, 60, height);
  rect(width * 0.65 - 60, 0, 60, height);

  // Tirai panjang
  fill(180, 50, 50, 200); // Merah tua transparan
  rect(width * 0.1 + 80, 0, 50, height * 0.8);
  rect(width * 0.9 - 80 - 50, 0, 50, height * 0.8);

  // Lantai berpola
  for (int i = 0; i < width / 50; i++) {
    for (int j = 0; j < height / 50; j++) {
      if ((i + j) % 2 == 0) {
        fill(100, 70, 30); // Coklat gelap
      } else {
        fill(130, 90, 40); // Coklat terang
      }
      rect(i * 50, j * 50, 50, 50);
    }
  }

  // Cahaya dari atas (simulasi)
  fill(255, 255, 200, 50); // Kuning muda transparan
  ellipse(width / 2, height / 2, width * 0.8, height * 0.8);

  // Dua sosok laki-laki berdiskusi, lalu Batara Guru memberi perintah
  drawBataraGuru(width * 0.65, height * 0.6, 0.8); // Skala 0.8
  drawAdvisor(width * 0.35, height * 0.6, 0.8); // Skala 0.8

  // Animasi gesture perintah
  float commandProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (commandProgress > 0.5) {
    // Lengan Batara Guru sedikit terangkat
    pushMatrix();
    translate(width * 0.65, height * 0.6);
    scale(0.8);
    fill(200, 160, 120); // Warna kulit
    rect(40, -80, 10, 40); // Lengan kanan
    ellipse(45, -40, 15, 15); // Tangan kanan
    popMatrix();
  }
}

void drawFrame4(long elapsedTime) { // Asli F5
  background(100, 150, 200); // Latar belakang langit biru

  // Awan tipis
  drawRealisticClouds(width * 0.3, height * 0.2, 400, 150);
  drawRealisticClouds(width * 0.7, height * 0.8, 500, 200);
  drawRealisticClouds(width * 0.5, height * 0.5, 300, 100);

  // Animasi turun
  descentY = map(elapsedTime, 0, frameDuration, -200, targetDescentY);

  // Batara Guru Lolo ri Sérenaé melayang di langit
  // Tubuh vertikal, jubah mengembang ke atas
  drawBataraGuruLoloDescending(width / 2, descentY, 1.0); // Skala 1.0
}

void drawFrame5(long elapsedTime) { // Asli F6
  background(150, 200, 100); // Latar belakang padang rumput (hijau muda)

  // Kabut pagi
  float mistAlpha = map(elapsedTime, 0, frameDuration, 0, 150);
  fill(200, 220, 255, mistAlpha); // Biru muda transparan
  rect(0, height * 0.6, width, height * 0.4);

  // Pepohonan di belakang
  fill(80, 120, 60); // Hijau tua untuk pohon
  triangle(width * 0.2, height * 0.8, width * 0.1, height * 0.5, width * 0.3, height * 0.5);
  triangle(width * 0.8, height * 0.7, width * 0.7, height * 0.4, width * 0.9, height * 0.4);
  rect(width * 0.2 - 10, height * 0.8, 20, 50); // Batang pohon
  rect(width * 0.8 - 10, height * 0.7, 20, 50); // Batang pohon

  // Animasi pendaratan
  landingProgress = map(elapsedTime, 0, frameDuration, 0, 1);

  // Pendaratan heroik di padang rumput
  // Lutut kiri dan tangan kiri menyentuh tanah, tangan kanan terbuka ke samping
  drawBataraGuruLoloLanding(width / 2, height * 0.8, landingProgress);
}

void drawFrame6(long elapsedTime) { // Asli F7
  background(180, 220, 255); // Latar belakang langit cerah

  // Gunung lebih realistis
  fill(120, 100, 80); // Coklat keabu-abuan
  beginShape();
  vertex(width * 0.0, height * 0.8);
  vertex(width * 0.2, height * 0.4);
  vertex(width * 0.3, height * 0.6);
  vertex(width * 0.4, height * 0.3);
  vertex(width * 0.6, height * 0.5);
  vertex(width * 0.7, height * 0.2);
  vertex(width * 0.9, height * 0.7);
  vertex(width * 1.0, height * 0.8);
  endShape(CLOSE);

  // Sungai kecil
  fill(80, 150, 200); // Biru sungai
  beginShape();
  vertex(width * 0.7, height * 0.85);
  bezierVertex(width * 0.75, height * 0.75, width * 0.85, height * 0.7, width * 0.9, height * 0.7);
  bezierVertex(width * 0.95, height * 0.8, width * 0.98, height * 0.9, width, height * 0.9);
  vertex(width, height);
  vertex(width * 0.6, height);
  endShape(CLOSE);

  // Pohon rindang
  fill(60, 100, 40); // Hijau tua
  ellipse(width * 0.2, height * 0.7, 150, 100);
  ellipse(width * 0.8, height * 0.6, 180, 120);
  fill(100, 70, 30); // Batang pohon
  rect(width * 0.2 - 10, height * 0.7, 20, 80);
  rect(width * 0.8 - 10, height * 0.6, 20, 80);

  // Animasi berjalan
  walkX = map(elapsedTime, 0, frameDuration, -100, width + 100); // Berjalan melintasi layar

  // Tokoh berjalan sendirian menyusuri lanskap alam Sulawesi
  // Ia membawa tongkat sederhana
  drawBataraGuruLoloWalking(walkX, height * 0.75, 0.9);
}

void drawFrame7(long elapsedTime) { // Gabungan F7 & F8
  background(180, 220, 255); // Latar belakang langit cerah

  // Hutan tropis (lereng bukit) - lebih kompleks
  fill(40, 80, 20); // Hijau gelap
  beginShape();
  vertex(0, height * 0.8);
  bezierVertex(width * 0.1, height * 0.7, width * 0.2, height * 0.6, width * 0.3, height * 0.6);
  bezierVertex(width * 0.4, height * 0.5, width * 0.5, height * 0.6, width * 0.7, height * 0.7);
  bezierVertex(width * 0.8, height * 0.8, width * 0.9, height * 0.85, width, height * 0.9);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  // Lereng bukit di kejauhan - lebih kompleks
  fill(90, 130, 70); // Hijau lebih terang
  beginShape();
  vertex(width * 0.1, height * 0.7);
  bezierVertex(width * 0.2, height * 0.6, width * 0.3, height * 0.65, width * 0.4, height * 0.6);
  bezierVertex(width * 0.5, height * 0.55, width * 0.6, height * 0.6, width * 0.7, height * 0.55);
  bezierVertex(width * 0.8, height * 0.5, width * 0.9, height * 0.6, width, height * 0.7);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);


  // Cakrawala yang terbuka lebar
  // Langit sudah digambar di background

  // Burung terbang di kejauhan (animasi lebih realistis)
  float birdX = map(elapsedTime, 0, frameDuration, 0, width);
  float birdY = map(sin(elapsedTime * 0.002), -1, 1, height * 0.1, height * 0.3);

  for (int i = 0; i < 5; i++) { // Beberapa burung
    float currentBirdX = (birdX + i * 100) % (width + 200) - 100; // Loop burung melintasi layar
    float currentBirdY = birdY + sin(currentBirdX * 0.01 + millis() * 0.001) * 20; // Jalur terbang bergelombang
    drawRealisticBird(currentBirdX, currentBirdY, 20 + i * 2); // Variasi ukuran
  }
}

void drawFrame8(long elapsedTime) { // Gabungan F9 & F10
  background(100, 150, 200); // Latar belakang langit biru

  // Awan
  drawRealisticClouds(width * 0.3, height * 0.2, 400, 150);
  drawRealisticClouds(width * 0.7, height * 0.8, 500, 200);
  drawRealisticClouds(width * 0.5, height * 0.5, 300, 100);

  // Batara Guru Lolo ri Sérenaé melayang
  lookDownOffset = map(elapsedTime, 0, frameDuration, 0, 20); // Animasi melihat ke bawah
  pushMatrix();
  translate(width / 2, height * 0.2 + lookDownOffset);
  drawBataraGuruLolo(0, 0, 0.8, false); // Skala 0.8, tidak berlutut
  popMatrix();

  // Hutan terbuka di bawah
  fill(60, 100, 40); // Hijau hutan
  rect(0, height * 0.7, width, height * 0.3);
  drawTree(width * 0.2, height * 0.7, 80, 150);
  drawTree(width * 0.8, height * 0.75, 100, 180);

  // We Nyili Timo berdiri di hutan (close-up tersirat)
  drawWeNyiliTimo(width * 0.5, height * 0.85, 0.7);
}

void drawFrame9(long elapsedTime) { // Asli F11
  background(150, 200, 100); // Latar belakang padang ilalang (hijau muda)

  // Padang ilalang
  for (int i = 0; i < width; i += 20) {
    float grassHeight = random(20, 50);
    fill(120, 180, 80);
    rect(i, height - grassHeight, 10, grassHeight);
  }

  // Batara Guru Lolo ri Sérenaé dan We Nyili Timo berdiri saling berhadapan
  drawBataraGuruLolo(width * 0.35, height * 0.7, 0.9, false);
  drawWeNyiliTimo(width * 0.65, height * 0.7, 0.9);

  // Simbol hati kecil terpancar
  heartSize = map(elapsedTime, 0, frameDuration, 0, 50);
  fill(255, 100, 100, 200); // Merah muda transparan
  drawHeart(width / 2, height * 0.4, heartSize);

  // Angin meniup kain dan rambut keduanya (diimplementasikan di fungsi gambar karakter)
}

void drawFrame10(long elapsedTime) { // Asli F12
  background(200, 220, 255); // Latar belakang cerah

  // Gambar silsilah keluarga berbentuk pohon bercabang
  float treeBaseX = width / 2;
  float treeBaseY = height * 0.9;
  float treeHeight = height * 0.8;

  // Batang pohon
  fill(100, 70, 30);
  rect(treeBaseX - 20, treeBaseY - treeHeight, 40, treeHeight);

  // Cabang utama (Batara Guru & We Nyili Timo)
  stroke(100, 70, 30);
  strokeWeight(5);
  line(treeBaseX, treeBaseY - treeHeight, treeBaseX - 150, treeBaseY - treeHeight * 0.7);
  line(treeBaseX, treeBaseY - treeHeight, treeBaseX + 150, treeBaseY - treeHeight * 0.7);
  noStroke();

  // Lingkaran untuk karakter
  fill(180, 140, 80); // Warna emas untuk lingkaran
  ellipse(treeBaseX - 150, treeBaseY - treeHeight * 0.7, 60, 60); // Batara Guru
  ellipse(treeBaseX + 150, treeBaseY - treeHeight * 0.7, 60, 60); // We Nyili Timo

  // Teks nama (sederhana)
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Batara Guru", treeBaseX - 150, treeBaseY - treeHeight * 0.7);
  text("We Nyili Timo", treeBaseX + 150, treeBaseY - treeHeight * 0.7);

  // Cabang ke Sawerigading
  stroke(100, 70, 30);
  line(treeBaseX - 150, treeBaseY - treeHeight * 0.7, treeBaseX, treeBaseY - treeHeight * 0.3);
  line(treeBaseX + 150, treeBaseY - treeHeight * 0.7, treeBaseX, treeBaseY - treeHeight * 0.3);
  noStroke();

  fill(180, 140, 80);
  ellipse(treeBaseX, treeBaseY - treeHeight * 0.3, 60, 60); // Sawerigading

  fill(0);
  text("Sawerigading", treeBaseX, treeBaseY - treeHeight * 0.3);

  // Efek bercahaya pada pohon
  noFill();
  stroke(255, 255, 200, 100);
  strokeWeight(2);
  ellipse(treeBaseX, treeBaseY - treeHeight * 0.5, treeHeight * 0.5, treeHeight * 0.5);
}

void drawFrame11(long elapsedTime) { // Gabungan F13 & F14
  background(50, 30, 10); // Latar belakang ruangan (coklat)

  // Rak berisi kitab dan gulungan
  fill(80, 50, 20); // Coklat gelap untuk rak
  rect(width * 0.1, height * 0.2, width * 0.2, height * 0.6);
  rect(width * 0.7, height * 0.2, width * 0.2, height * 0.6);

  // Buku dan gulungan
  fill(150, 100, 50);
  rect(width * 0.12, height * 0.25, 40, 60);
  rect(width * 0.18, height * 0.3, 50, 70);
  fill(200, 200, 150); // Gulungan
  ellipse(width * 0.15, height * 0.45, 60, 20);

  fill(150, 100, 50);
  rect(width * 0.72, height * 0.35, 40, 60);
  rect(width * 0.78, height * 0.4, 50, 70);
  fill(200, 200, 150);
  ellipse(width * 0.75, height * 0.55, 60, 20);

  // Lantai
  fill(70, 40, 10);
  rect(0, height * 0.8, width, height * 0.2);

  // Kotak kayu tua dengan ukiran simbol kuno
  float boxX = width / 2;
  float boxY = height * 0.7;
  float boxWidth = 150;
  float boxHeight = 100;
  fill(120, 90, 60); // Coklat kayu
  rect(boxX - boxWidth / 2, boxY - boxHeight / 2, boxWidth, boxHeight, 5);
  // Tutup kotak terbuka
  pushMatrix();
  translate(boxX, boxY - boxHeight / 2);
  rotate(radians(-30)); // Tutup terbuka
  rect(-boxWidth / 2, -10, boxWidth, 20, 5);
  popMatrix();

  // Bola bercahaya yang terbelah
  orbSplitProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  float orbSize = 50;
  float splitOffset = map(orbSplitProgress, 0, 1, 0, 30);

  // Bola kiri
  fill(255, 255, 200, 200); // Kuning bercahaya
  ellipse(boxX - splitOffset, boxY - boxHeight / 2 - orbSize, orbSize, orbSize);
  // Bola kanan
  ellipse(boxX + splitOffset, boxY - boxHeight / 2 - orbSize, orbSize, orbSize);

  // Cahaya menyinari wajah Sawerigading
  fill(255, 255, 200, 100); // Cahaya lembut
  ellipse(boxX, boxY - boxHeight / 2 - orbSize / 2, orbSize * 2, orbSize * 2);

  // Sawerigading takjub
  drawSawerigadingChild(boxX, boxY - 80, 0.8, true); // True untuk menatap kotak
}

void drawFrame12(long elapsedTime) { // Asli F15
  // Frame terbagi dua
  float splitLineX = width / 2;

  // Sisi kiri: Sawerigading kecil di padang rumput
  pushMatrix();
  clip(0, 0, splitLineX, height); // Batasi gambar di sisi kiri
  background(150, 200, 100); // Padang rumput
  for (int i = 0; i < splitLineX; i += 20) {
    float grassHeight = random(20, 50);
    fill(120, 180, 80);
    rect(i, height - grassHeight, 10, grassHeight);
  }
  drawSawerigadingChild(splitLineX * 0.5, height * 0.75, 0.9, false);
  popMatrix();
  noClip();

  // Sisi kanan: We Tenriabéng di taman bunga
  pushMatrix();
  clip(splitLineX, 0, width - splitLineX, height); // Batasi gambar di sisi kanan
  background(200, 150, 200); // Taman bunga (merah muda)
  fill(180, 100, 150); // Bunga
  for (int i = (int)splitLineX; i < width; i += 30) {
    for (int j = (int)(height * 0.6); j < height; j += 30) {
      ellipse(i + random(-10, 10), j + random(-10, 10), 20, 20);
    }
  }
  drawWeTenriabengChild(splitLineX + (width - splitLineX) * 0.5, height * 0.75, 0.9);
  popMatrix();
  noClip();

  // Efek pemisahan realistis - distorsi/blur halus di dekat garis
  float separationEffect = map(sin(elapsedTime * 0.001), -1, 1, 0, 5); // Distorsi halus
  filter(BLUR, separationEffect); // Terapkan filter blur
  stroke(255, 255, 200, 100); // Garis bercahaya lembut
  strokeWeight(5);
  line(splitLineX, 0, splitLineX, height);
  noStroke();
}

void drawFrame13(long elapsedTime) { // Asli F16
  // Masih terbagi dua
  float splitLineX = width / 2;

  // Sisi kiri: Sawerigading dewasa
  pushMatrix();
  clip(0, 0, splitLineX, height);
  background(150, 100, 50); // Latar belakang istana
  drawPalaceHallBackground(); // Gunakan kembali elemen latar belakang
  drawSawerigadingAdult(splitLineX * 0.5, height * 0.7, 1.0);
  popMatrix();
  noClip();

  // Sisi kanan: We Tenriabéng dewasa
  pushMatrix();
  clip(splitLineX, 0, width - splitLineX, height);
  background(200, 150, 200); // Latar belakang taman bunga
  fill(180, 100, 150); // Bunga
  for (int i = (int)splitLineX; i < width; i += 30) {
    for (int j = (int)(height * 0.6); j < height; j += 30) {
      ellipse(i + random(-10, 10), j + random(-10, 10), 20, 20);
    }
  }
  drawWeTenriabengAdult(splitLineX + (width - splitLineX) * 0.5, height * 0.7, 1.0);
  popMatrix();
  noClip();

  // Efek pemisahan realistis - memudar
  float separationAlpha = map(elapsedTime, 0, frameDuration, 150, 0);
  fill(100, 100, 100, separationAlpha);
  noStroke();
  rect(splitLineX - 2, 0, 4, height); // Garis memudar halus
}

void drawFrame14(long elapsedTime) { // Gabungan F17 & F18
  background(180, 220, 255); // Latar belakang langit senja

  // Taman dengan cahaya temaram, pohon berbunga
  fill(100, 150, 80); // Hijau gelap untuk tanah
  rect(0, height * 0.7, width, height * 0.3);

  drawFloweringTree(width * 0.3, height * 0.5, 200, 300);
  drawFloweringTree(width * 0.7, height * 0.6, 180, 280);

  // Bangku kayu ukir
  fill(120, 90, 60); // Coklat kayu
  rect(width * 0.35, height * 0.7 - 50, width * 0.3, 30, 5); // Dudukan
  rect(width * 0.35 + 10, height * 0.7 - 80, width * 0.3 - 20, 30, 5); // Sandaran
  // Ukiran (sederhana)
  stroke(50, 30, 10);
  line(width * 0.4, height * 0.7 - 70, width * 0.4 + 20, height * 0.7 - 70);
  line(width * 0.5, height * 0.7 - 70, width * 0.5 + 20, height * 0.7 - 70);
  noStroke();

  // Sawerigading dan We Tenriabéng duduk berbincang
  drawSawerigadingAdult(width * 0.45, height * 0.7 - 20, 0.8);
  drawWeTenriabengAdult(width * 0.55, height * 0.7 - 20, 0.8);

  // Daun-daun gugur perlahan
  if (random(1) < 0.1) { // Tambahkan daun baru secara acak
    fallingLeaves.add(new Leaf(random(width), random(height * 0.2, height * 0.5)));
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

class Leaf {
  PVector pos;
  float speed;
  float rotation;
  float rotationSpeed;
  color leafColor;

  Leaf(float x, float y) {
    pos = new PVector(x, y);
    speed = random(0.5, 2);
    rotation = random(TWO_PI);
    rotationSpeed = random(-0.05, 0.05);
    leafColor = color(random(100, 150), random(50, 100), random(0, 50)); // Warna daun gugur
  }

  void update() {
    pos.y += speed;
    pos.x += sin(millis() * 0.001 + pos.x) * 0.5; // Efek angin
    rotation += rotationSpeed;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    fill(leafColor, 200); // Sedikit transparan
    noStroke();
    ellipse(0, 0, 10, 15); // Bentuk daun sederhana
    popMatrix();
  }

  boolean isDead() {
    return pos.y > height;
  }
}


void drawFrame15(long elapsedTime) { // Asli F19
  background(180, 220, 255); // Latar belakang langit cerah

  // Jalan batu dengan pohon rindang di sisi
  fill(150, 150, 150); // Abu-abu batu
  beginShape();
  vertex(0, height * 0.8);
  vertex(width * 0.3, height * 0.6);
  vertex(width * 0.7, height * 0.6);
  vertex(width, height * 0.8);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  drawTree(width * 0.1, height * 0.5, 150, 250);
  drawTree(width * 0.9, height * 0.55, 160, 260);

  // Istana di kejauhan
  fill(180, 140, 80);
  rect(width * 0.75, height * 0.3, 100, 80, 5);
  fill(120, 80, 40);
  triangle(width * 0.75, height * 0.3, width * 0.8, height * 0.2, width * 0.85, height * 0.3);

  // Sawerigading tampak dari belakang berjalan
  float walkProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  float currentWalkX = map(walkProgress, 0, 1, width * 0.2, width * 0.6);
  float currentWalkY = map(walkProgress, 0, 1, height * 0.7, height * 0.65);

  drawSawerigadingAdultBack(currentWalkX, currentWalkY, 0.9);
}

void drawFrame16(long elapsedTime) { // Asli F20
  background(150, 100, 50); // Latar belakang aula istana

  drawPalaceHallBackground();

  // Batara Lattu seated on the throne
  drawBataraLattu(width * 0.6, height * 0.6, 1.0);

  // Sawerigading standing in front of him
  drawSawerigadingAdult(width * 0.3, height * 0.7, 0.9);
}

void drawFrame17(long elapsedTime) { // Gabungan F21 & F22
  background(150, 200, 100); // Latar belakang padang rumput

  // Pohon besar
  fill(100, 70, 30); // Batang
  rect(width * 0.5 - 30, height * 0.4, 60, height * 0.6);
  fill(60, 120, 40); // Daun
  ellipse(width * 0.5, height * 0.4, 300, 250);

  // Sawerigading duduk di bawah pohon, lalu mengangkat kepala
  float ideaProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (ideaProgress < 0.5) {
    drawSawerigadingAdultDespair(width * 0.5, height * 0.8, 0.8);
  } else {
    drawSawerigadingAdultNewIdea(width * 0.5, height * 0.8, 0.8);
    // Awan pikiran dengan simbol centang
    fill(255, 255, 255, 200);
    ellipse(width * 0.65, height * 0.4, 150, 80);
    fill(50, 200, 50); // Hijau untuk centang
    textSize(50);
    textAlign(CENTER, CENTER);
    text("✓", width * 0.65, height * 0.4);
  }

  // Perisai dan pedang
  fill(150, 150, 150); // Perisai
  ellipse(width * 0.5 - 100, height * 0.85, 80, 100);
  fill(100, 100, 100); // Pedang
  rect(width * 0.5 - 150, height * 0.9, 10, 80);
  triangle(width * 0.5 - 150, height * 0.9, width * 0.5 - 145, height * 0.88, width * 0.5 - 155, height * 0.88);

  // Daun-daun gugur perlahan
  if (random(1) < 0.1) {
    fallingLeaves.add(new Leaf(random(width * 0.4, width * 0.6), random(height * 0.2, height * 0.4)));
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

void drawFrame18(long elapsedTime) { // Asli F23
  background(20, 20, 50); // Latar belakang malam hari
  // Langit bertabur bintang
  fill(255);
  for (int i = 0; i < 100; i++) {
    ellipse(random(width), random(height * 0.7), random(1, 3), random(1, 3));
  }
  // Bulan
  fill(200);
  ellipse(width * 0.8, height * 0.2, 80, 80);

  // Balkon istana
  fill(180, 140, 80); // Emas
  rect(width * 0.2, height * 0.6, width * 0.6, 50, 10);
  fill(150, 110, 60); // Tiang balkon
  rect(width * 0.2 + 20, height * 0.6 + 50, 20, 100);
  rect(width * 0.8 - 40, height * 0.6 + 50, 20, 100);

  // Sawerigading berdiri gagah, tangan kanan ke dada bersumpah
  drawSawerigadingAdultVowing(width * 0.5, height * 0.6, 1.0);
}

void drawFrame19(long elapsedTime) { // Gabungan F24 & F25
  background(80, 140, 60); // Latar belakang hutan

  // Pohon besar yang ditebang dan roboh
  float chopProgress = map(elapsedTime, 0, frameDuration, 0, 1);
  if (chopProgress < 0.7) { // Fase menebang
    fill(100, 70, 30); // Batang
    rect(width * 0.7 - 40, height * 0.4, 80, height * 0.6);
    fill(60, 120, 40); // Daun
    ellipse(width * 0.7, height * 0.4, 350, 300);
    drawSawerigadingAdultChopping(width * 0.3, height * 0.8, 0.9, elapsedTime);

    // Kayu mulai retak
    treeCrackProgress = map(elapsedTime, 0, frameDuration * 0.7, 0, 1);
    if (treeCrackProgress > 0.5) {
      stroke(0);
      strokeWeight(3);
      line(width * 0.7 - 20, height * 0.9, width * 0.7 + 20, height * 0.85);
      line(width * 0.7 - 10, height * 0.95, width * 0.7 + 30, height * 0.9);
      noStroke();
    }
  } else { // Fase roboh
    float fallRotation = map(chopProgress, 0.7, 1, 0, PI / 2); // Rotasi 90 derajat
    pushMatrix();
    translate(width * 0.7, height * 0.9);
    rotate(fallRotation);
    fill(100, 70, 30); // Batang
    rect(-40, -height * 0.5, 80, height * 0.5); // Batang pohon
    fill(60, 120, 40); // Daun
    ellipse(0, -height * 0.5, 350, 300);
    popMatrix();

    // Dahan-dahan menyebar ke tanah
    fill(100, 70, 30);
    rect(width * 0.5, height * 0.9, 100, 20);
    rect(width * 0.8, height * 0.85, 80, 15);

    // Efek gerakan digambarkan dengan garis kejut
    stroke(150, 150, 150, 100);
    strokeWeight(5);
    line(width * 0.7, height * 0.9, width * 0.7 - 100, height * 0.9 - 50);
    line(width * 0.7, height * 0.9, width * 0.7 + 100, height * 0.9 - 50);
    noStroke();
  }


  // Tanaman liar
  fill(70, 110, 50);
  rect(0, height * 0.9, width, height * 0.1);

  // Burung terbang menjauh
  fill(50);
  drawRealisticBird(width * 0.1, height * 0.1, 15);
  drawRealisticBird(width * 0.9, height * 0.15, 20);
}

void drawFrame20(long elapsedTime) { // Asli F26
  background(180, 220, 255); // Latar belakang langit cerah
  fill(100, 70, 30); // Tanah
  rect(0, height * 0.7, width, height * 0.3);

  // Kayu yang sedang dibentuk
  fill(120, 90, 60);
  rect(width * 0.2, height * 0.75, 200, 50, 10);
  rect(width * 0.5, height * 0.78, 250, 60, 15);

  // Pengrajin dan bissu
  drawCraftsman(width * 0.25, height * 0.85, 0.7);
  drawCraftsman(width * 0.45, height * 0.8, 0.8);
  drawBissu(width * 0.7, height * 0.85, 0.7);

  // Alat-alat sederhana berserakan
  fill(100); // Kapak
  rect(width * 0.1, height * 0.9, 10, 30);
  triangle(width * 0.1 - 10, height * 0.9, width * 0.1 + 20, height * 0.9, width * 0.1 + 5, height * 0.85);
  fill(100, 70, 30); // Pahat
  rect(width * 0.8, height * 0.92, 5, 40);
}

void drawFrame21(long elapsedTime) { // Asli F27
  background(180, 220, 255); // Latar belakang langit cerah

  // Sungai
  fill(80, 150, 200);
  rect(0, height * 0.7, width, height * 0.3);

  // Kapal megah selesai dibangun (lebih detail)
  drawShip(width / 2, height * 0.6, 1.0, false); // Kapal diam, layar tergulung

  // Bissu memberkati kapal dengan asap dupa
  drawBissu(width * 0.7, height * 0.8, 0.8);
  float incenseX = width * 0.7 + 20;
  float incenseY = height * 0.8 - 50;
  fill(200, 200, 200, 100); // Asap
  ellipse(incenseX, incenseY, 30, 40);
  ellipse(incenseX + 10, incenseY - 20, 25, 35);
}

void drawFrame22(long elapsedTime) { // Asli F28
  background(80, 150, 200); // Latar belakang laut lepas (biru)

  // Ombak bergulung (lebih realistis)
  waveOffset = (millis() * 0.005) % (width * 2); // Gerakan ombak berkelanjutan
  drawWaves(waveOffset);

  // Kapal Sawerigading bergerak (lebih detail)
  shipX = map(elapsedTime, 0, frameDuration, -300, width + 300);
  float shipY = height * 0.6 + sin(millis() * 0.002) * 10; // Animasi mengapung
  drawShip(shipX, shipY, 1.0, true); // Kapal bergerak, layar terkembang

  // Sawerigading berdiri di atas kapal
  drawSawerigadingAdult(shipX, shipY - 50, 0.9);

  // Angin meniup kainnya (diimplementasikan di fungsi gambar karakter)

  // Burung camar terbang
  fill(255);
  drawRealisticBird(width * 0.1, height * 0.1, 20);
  drawRealisticBird(width * 0.9, height * 0.15, 25);
}

void drawFrame23(long elapsedTime) { // Asli F29
  background(50, 80, 120); // Latar belakang laut badai (biru gelap)

  // Ombak bergulung hebat
  fill(30, 60, 90);
  ellipse(width * 0.2, height * 0.9, 600, 150);
  ellipse(width * 0.8, height * 0.85, 700, 180);

  // Kapal bergoyang hebat
  float shipShake = sin(millis() * 0.01) * 10;
  float shipY = height * 0.6 + shipShake;
  float shipWidth = 400;
  float shipHeight = 150;

  pushMatrix();
  translate(width / 2, shipY);
  rotate(radians(sin(millis() * 0.008) * 5)); // Goyangan kapal
  drawShip(0, 0, 1.0, true); // Kapal bergerak, layar terkembang
  popMatrix();

  // Sawerigading bertarung
  drawSawerigadingAdult(width * 0.4, shipY - 50, 0.9);
  drawEnemyWarrior(width * 0.6, shipY - 50, 0.9);

  // Petir menyambar dari langit
  stroke(255, 255, 0);
  strokeWeight(5);
  if (millis() % 1000 < 200) { // Efek kilat
    line(random(width * 0.2, width * 0.8), 0, random(width * 0.2, width * 0.8), height);
    line(random(width * 0.2, width * 0.8), 0, random(width * 0.2, width * 0.8), height);
  }
  noStroke();
}

void drawFrame24(long elapsedTime) { // Asli F30
  background(180, 220, 255); // Latar belakang langit cerah

  // Pantai
  fill(255, 230, 180); // Pasir
  rect(0, height * 0.7, width, height * 0.3);

  // Ombak tenang menyambut kapal
  fill(80, 150, 200);
  ellipse(width * 0.5, height * 0.75, width * 0.8, 100);

  // Pohon kelapa berjajar di pantai
  drawPalmTree(width * 0.1, height * 0.7);
  drawPalmTree(width * 0.9, height * 0.75);
  drawPalmTree(width * 0.3, height * 0.8);

  // Gunung menjulang di kejauhan
  fill(120, 100, 80);
  beginShape();
  vertex(width * 0.6, height * 0.3);
  vertex(width * 0.75, height * 0.1);
  vertex(width * 0.9, height * 0.3);
  vertex(width * 0.8, height * 0.5);
  endShape(CLOSE);

  // Kapal Sawerigading tiba
  float shipX = map(elapsedTime, 0, frameDuration, -300, width * 0.2); // Bergerak ke posisi berlabuh
  float shipY = height * 0.6;
  drawShip(shipX, shipY, 1.0, false); // Kapal diam, layar tergulung
}

void drawFrame25(long elapsedTime) { // Gabungan F31 & F32
  background(180, 220, 255); // Latar belakang langit cerah

  // Pohon berbunga
  drawFloweringTree(width * 0.5, height * 0.5, 250, 350);

  // Sawerigading bertemu seorang wanita (We Cudaiq) yang mirip saudara kembarnya. Mereka tersenyum dan saling mendekat.
  float approachOffset = map(elapsedTime, 0, frameDuration, 0, 20);
  drawSawerigadingAdult(width * 0.4 - approachOffset, height * 0.75, 0.9);
  drawWeCudaiq(width * 0.6 + approachOffset, height * 0.75, 0.9);

  // Simbol hati kecil di antara mereka
  heartSize = map(elapsedTime, 0, frameDuration, 0, 50);
  fill(255, 100, 100, 200); // Merah muda transparan
  drawHeart(width / 2, height * 0.4, heartSize);
}

void drawFrame26(long elapsedTime) { // Asli F33
  background(100, 70, 30); // Latar belakang interior rumah kayu sederhana

  // Dinding kayu
  fill(120, 90, 60);
  rect(width * 0.1, height * 0.1, width * 0.8, height * 0.8, 10);
  // Detail kayu
  stroke(80, 60, 40);
  strokeWeight(2);
  line(width * 0.1 + 50, height * 0.1, width * 0.1 + 50, height * 0.9);
  line(width * 0.1 + 100, height * 0.1, width * 0.1 + 100, height * 0.9);
  noStroke();

  // Tempat tidur/alas
  fill(180, 140, 80);
  rect(width * 0.3, height * 0.6, width * 0.4, 50, 5);

  // Bayi La Galigo lahir dan digendong oleh sang ibu
  drawWeCudaiqHoldingBaby(width * 0.55, height * 0.7, 1.0);

  // Sawerigading berdiri di sisi mereka dengan wajah lembut
  drawSawerigadingAdult(width * 0.35, height * 0.7, 0.9);
}

void drawFrame27(long elapsedTime) { // Asli F34
  background(150, 100, 50); // Latar belakang hiasan dinding kerajaan

  // Hiasan dinding kerajaan (pola sederhana)
  fill(180, 140, 80); // Emas
  rect(width * 0.1, height * 0.1, width * 0.8, height * 0.8, 15);
  fill(200, 160, 100);
  ellipse(width * 0.3, height * 0.3, 80, 80);
  ellipse(width * 0.7, height * 0.3, 80, 80);
  rect(width * 0.4, height * 0.5, 20, 100);
  rect(width * 0.6 - 20, height * 0.5, 20, 100);

  // Potret keluarga: Sawerigading, istrinya, dan La Galigo balita duduk bersama
  drawSawerigadingAdult(width * 0.3, height * 0.7, 0.9);
  drawWeCudaiq(width * 0.5, height * 0.7, 0.9);
  drawLaGaligoToddler(width * 0.7, height * 0.7, 0.7);
}


// --- Fungsi Pembantu untuk Menggambar Karakter dan Elemen ---

void drawPalaceHallBackground() {
  // Latar belakang berupa pilar
  fill(200, 160, 100); // Pilar emas/krem
  rect(width * 0.1, 0, 80, height);
  rect(width * 0.9 - 80, 0, 80, height);
  rect(width * 0.35, 0, 60, height);
  rect(width * 0.65 - 60, 0, 60, height);

  // Tirai panjang
  fill(180, 50, 50, 200); // Merah tua transparan
  rect(width * 0.1 + 80, 0, 50, height * 0.8);
  rect(width * 0.9 - 80 - 50, 0, 50, height * 0.8);

  // Lantai berpola
  for (int i = 0; i < width / 50; i++) {
    for (int j = 0; j < height / 50; j++) {
      if ((i + j) % 2 == 0) {
        fill(100, 70, 30); // Coklat gelap
      } else {
        fill(130, 90, 40); // Coklat terang
      }
      rect(i * 50, j * 50, 50, 50);
    }
  }

  // Cahaya dari atas (simulasi)
  fill(255, 255, 200, 50); // Kuning muda transparan
  ellipse(width / 2, height / 2, width * 0.8, height * 0.8);
}

void drawBataraGuru(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh: Torso dan anggota badan yang lebih jelas
  fill(100, 50, 0); // Jubah coklat tua
  beginShape();
  vertex(-40, -150);
  vertex(40, -150);
  vertex(50, 50);
  vertex(-50, 50);
  endShape(CLOSE);
  fill(120, 60, 0); // Lapisan jubah
  beginShape();
  vertex(-30, -140);
  vertex(30, -140);
  vertex(40, 40);
  vertex(-40, 40);
  endShape(CLOSE);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -170, 60, 60);

  // Rambut (panjang dan tipis, di atas kepala)
  fill(50, 30, 0); // Coklat gelap untuk rambut
  beginShape();
  vertex(-25, -200);
  bezierVertex(-35, -210, -40, -190, -30, -165);
  bezierVertex(-20, -150, 20, -150, 30, -165);
  bezierVertex(40, -190, 35, -210, 25, -200);
  endShape(CLOSE);

  // Janggut (tipis, tidak menutupi setengah muka)
  fill(150, 150, 150); // Abu-abu
  beginShape();
  vertex(-5, -145);
  bezierVertex(-10, -130, -5, -115, 0, -100);
  bezierVertex(5, -115, 10, -130, 5, -145);
  endShape(CLOSE);

  // Wajah: Mata, Hidung, Mulut
  fill(0); // Mata
  if (isBlinking) {
    line(-10, -175, 10, -175); // Mata tertutup
  } else {
    ellipse(-10, -175, 5, 5); // Mata kiri
    ellipse(10, -175, 5, 5); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-5, -165, 5, -165, 0, -160); // Hidung
  noFill();
  stroke(0);
  strokeWeight(1);
  arc(0, -160, 20, 10, 0, PI); // Mulut tenang
  line(-15, -168, 15, -168); // Alis

  // Mahkota dengan titik cahaya kecil
  fill(255, 255, 100, 200); // Kuning bercahaya
  arc(0, -160, 80, 40, PI, TWO_PI); // Setengah lingkaran
  ellipse(0, -160, 10, 10); // Titik cahaya di tengah

  // Ikat pinggang bermotif naga awan
  fill(180, 140, 80); // Emas
  rect(-40, -50, 80, 10);
  // Motif naga awan (simulasi dengan garis)
  stroke(0);
  strokeWeight(0.5);
  line(-30, -45, -20, -40);
  line(30, -45, 20, -40);
  noStroke();

  // Selendang di bahu kanan
  fill(200, 100, 0); // Oranye
  beginShape();
  vertex(20, -120);
  vertex(50, -100);
  vertex(50, 50);
  vertex(20, 30);
  endShape(CLOSE);

  // Aksesori: Gelang dan cincin logam dengan batu hitam kecil
  fill(150, 150, 150); // Perak
  ellipse(40, -80, 10, 10); // Gelang kiri
  ellipse(-40, -80, 10, 10); // Gelang kanan
  ellipse(0, -20, 5, 5); // Cincin

  popMatrix();
}

void drawAdvisor(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (kain putih polos selempang)
  fill(220); // Putih
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(30, 50);
  vertex(-30, 50);
  endShape(CLOSE); // Tubuh
  beginShape();
  vertex(-50, -100);
  vertex(50, -100);
  vertex(0, 50);
  endShape(CLOSE); // Kain selempang

  // Penutup kepala kain lilit, sederhana
  fill(180); // Abu-abu terang
  ellipse(0, -130, 70, 40);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -140, 60, 60);

  // Rambut di bawah penutup kepala
  fill(80, 80, 80); // Abu-abu gelap
  arc(0, -140, 60, 60, PI, TWO_PI); // Bentuk rambut di bagian belakang kepala

  // Wajah: Wajah keriput, mata sayu, janggut penuh
  fill(0); // Mata
  if (isBlinking) {
    line(-10, -145, 10, -145); // Mata tertutup
  } else {
    ellipse(-10, -145, 4, 4); // Mata kiri
    ellipse(10, -145, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -135, 4, -135, 0, -130); // Hidung
  noFill();
  stroke(0);
  strokeWeight(0.5);
  line(-15, -138, 15, -138); // Kerutan dahi
  line(-10, -130, 10, -130); // Kerutan mata
  if (isTalking) {
    arc(0, -130, 20, 15, 0, PI); // Mulut berbicara
  } else {
    arc(0, -130, 20, 10, 0, PI); // Mulut sayu
  }

  // Janggut penuh
  fill(150, 150, 150); // Abu-abu
  beginShape();
  vertex(-15, -110);
  bezierVertex(-20, -90, -10, -70, 0, -50);
  bezierVertex(10, -70, 20, -90, 15, -110);
  endShape(CLOSE);

  // Tongkat panjang sederhana dari kayu tua
  stroke(100, 70, 30); // Coklat kayu
  strokeWeight(5);
  line(50, 0, 60, 100); // Tongkat
  noStroke();

  popMatrix();
}

void drawBataraGuruLolo(float x, float y, float scaleFactor, boolean kneeling) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  if (kneeling) {
    // Posisi berlutut
    rotate(PI / 10); // Sedikit miring ke depan
    translate(0, 50); // Geser ke bawah sedikit
  }

  // Tubuh (jubah pendek terbuka seperti panglima)
  fill(80, 40, 0); // Coklat gelap
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(100, 50, 0); // Detail awan (simulasi)
  ellipse(-30, -110, 15, 15);
  ellipse(30, -110, 15, 15);

  // Celana panjang tradisional dengan sarung dilipat
  fill(50, 30, 0); // Coklat sangat gelap
  rect(-30, 30, 60, 50); // Celana
  fill(70, 40, 0); // Sarung
  rect(-35, 80, 70, 20, 5);

  // Selempang silang di dada, dari kain tenun bergaris
  fill(150, 100, 50); // Coklat keemasan
  beginShape();
  vertex(-40, -100);
  vertex(40, -100);
  vertex(40, 0);
  vertex(-40, 0);
  endShape(CLOSE);
  // Garis-garis
  stroke(0);
  strokeWeight(0.5);
  line(-35, -90, 35, -10);
  line(-35, -70, 35, 10);
  noStroke();

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut (pendek, gelap, tidak menghalangi muka)
  fill(30, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah: Wajah bulat tegas, dagu kokoh, mata tajam
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  noFill();
  stroke(0);
  strokeWeight(1);
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 15, 8, 0, PI); // Mulut tegas
  }
  line(-10, -128, 10, -128); // Alis

  // Aksesori: Kalung berbahan tulang dan batu
  fill(180, 180, 180); // Abu-abu tulang
  ellipse(0, -100, 5, 5);
  ellipse(-10, -105, 5, 5);
  ellipse(10, -105, 5, 5);

  // Lengan
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  popMatrix();
}

void drawBataraGuruLoloDescending(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Jubah mengembang ke atas (animasi sederhana)
  float robeFlare = map(sin(millis() * 0.005), -1, 1, 0, 20); // Efek mengembang
  fill(80, 40, 0, 200); // Coklat gelap transparan
  beginShape();
  vertex(-50, -120);
  vertex(50, -120);
  vertex(50 + robeFlare, 80);
  vertex(-50 - robeFlare, 80);
  endShape(CLOSE);

  // Tubuh
  fill(80, 40, 0); // Coklat gelap
  rect(-40, -120, 80, 100, 8); // Torso

  // Celana
  fill(50, 30, 0); // Coklat sangat gelap
  rect(-30, -20, 60, 50);

  // Selempang
  fill(150, 100, 50);
  rect(-40, -100, 80, 100);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut (pendek, gelap)
  fill(30, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Siluet tubuhnya bersinar ringan
  noFill();
  stroke(255, 255, 200, 150); // Kuning muda transparan
  strokeWeight(3);
  ellipse(0, -130, 60, 60); // Cahaya di kepala
  rect(-60, -130, 120, 250, 15); // Cahaya di sekitar tubuh
  noStroke();

  // Lengan dan kaki (posisi vertikal)
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 150); // Lengan kiri
  rect(40, -100, 10, 150); // Lengan kanan
  rect(-20, 30, 15, 70); // Kaki kiri
  rect(5, 30, 15, 70); // Kaki kanan

  popMatrix();
}

void drawBataraGuruLoloLanding(float x, float y, float progress) {
  pushMatrix();
  translate(x, y);

  // Posisi dan rotasi animasi berdasarkan progress
  float bodyRotation = map(progress, 0, 1, -PI / 4, 0); // Miring saat turun, lalu tegak
  float bodyYOffset = map(progress, 0, 1, -100, 0); // Turun ke posisi akhir

  translate(0, bodyYOffset);
  rotate(bodyRotation);

  // Tubuh
  fill(80, 40, 0); // Coklat gelap
  rect(-40, -120, 80, 100, 8); // Torso

  // Celana
  fill(50, 30, 0); // Coklat sangat gelap
  rect(-30, -20, 60, 50);

  // Selempang
  fill(150, 100, 50);
  rect(-40, -100, 80, 100);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut (pendek, gelap)
  fill(30, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  noFill();
  stroke(0);
  strokeWeight(1);
  arc(0, -120, 15, 8, 0, PI); // Mulut (tegas)
  line(-10, -128, 10, -128); // Alis

  // Lutut kiri menyentuh tanah (simulasi)
  float kneeBend = map(progress, 0, 1, 0, PI / 3);
  pushMatrix();
  translate(-20, 50);
  rotate(kneeBend);
  fill(50, 30, 0);
  rect(0, 0, 20, 50); // Paha
  rect(0, 50, 20, 50); // Betis
  ellipse(10, 100, 25, 10); // Kaki
  popMatrix();

  // Tangan kiri menyentuh tanah
  float armBend = map(progress, 0, 1, 0, PI / 2);
  pushMatrix();
  translate(-50, -50);
  rotate(armBend);
  fill(200, 160, 120);
  rect(0, 0, 10, 60); // Lengan
  ellipse(5, 60, 15, 15); // Tangan
  popMatrix();

  // Tangan kanan terentang ke samping
  pushMatrix();
  translate(50, -50);
  rotate(-PI / 6); // Sedikit terentang
  fill(200, 160, 120);
  rect(0, 0, 10, 60); // Lengan
  ellipse(5, 60, 15, 15); // Tangan
  popMatrix();

  // Kaki kanan (berdiri)
  fill(50, 30, 0);
  rect(5, 30, 15, 70); // Paha
  rect(5, 100, 15, 70); // Betis
  ellipse(12.5, 170, 25, 10); // Kaki

  popMatrix();
}

void drawBataraGuruLoloWalking(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Siklus animasi berjalan
  float walkCycle = sin(millis() * 0.005) * 20; // Untuk ayunan lengan/kaki

  // Tubuh
  fill(80, 40, 0); // Jubah coklat gelap
  rect(-40, -120, 80, 100, 8); // Torso

  // Celana
  fill(50, 30, 0); // Coklat sangat gelap
  rect(-30, -20, 60, 50);

  // Kaki (animasi berjalan)
  fill(50, 30, 0);
  pushMatrix();
  translate(-20, 30);
  rotate(radians(walkCycle));
  rect(0, 0, 20, 70); // Kaki depan (atas)
  rect(0, 70, 20, 70); // Kaki depan (bawah)
  ellipse(10, 140, 25, 10); // Kaki depan
  popMatrix();

  pushMatrix();
  translate(20, 30);
  rotate(radians(-walkCycle));
  rect(0, 0, 20, 70); // Kaki belakang (atas)
  rect(0, 70, 20, 70); // Kaki belakang (bawah)
  ellipse(10, 140, 25, 10); // Kaki belakang
  popMatrix();

  // Selempang
  fill(150, 100, 50);
  rect(-40, -100, 80, 100);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut (pendek, gelap)
  fill(30, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  noFill();
  stroke(0);
  strokeWeight(1);
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 15, 8, 0, PI); // Mulut tegas
  }
  line(-10, -128, 10, -128); // Alis

  // Lengan (animasi berjalan)
  fill(200, 160, 120); // Warna kulit
  pushMatrix();
  translate(-50, -50);
  rotate(radians(-walkCycle));
  rect(0, 0, 10, 60); // Lengan
  ellipse(5, 60, 15, 15); // Tangan
  popMatrix();

  pushMatrix();
  translate(50, -50);
  rotate(radians(walkCycle));
  rect(0, 0, 10, 60); // Lengan
  ellipse(5, 60, 15, 15); // Tangan
  popMatrix();

  // Tongkat sederhana
  stroke(100, 70, 30); // Coklat kayu
  strokeWeight(5);
  line(50, -20, 70, 80); // Tongkat di tangan kanan
  noStroke();

  popMatrix();
}

void drawRealisticBird(float x, float y, float size) {
  // Bentuk burung yang lebih realistis (siluet) dengan kepakan sayap
  float wingFlap = sin(millis() * 0.01) * size * 0.5; // Gerakan kepakan sederhana
  stroke(50);
  strokeWeight(2);
  noFill();
  // Sayap kiri
  bezier(x, y, x - size, y - size - wingFlap, x - size * 1.5, y - size * 0.5 - wingFlap, x - size * 0.5, y);
  // Sayap kanan
  bezier(x, y, x + size, y - size - wingFlap, x + size * 1.5, y - size * 0.5 - wingFlap, x + size * 0.5, y);
  noStroke();
}

void drawWeNyiliTimo(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (kebaya panjang sulam benang emas, lengan panjang ketat)
  fill(200, 150, 0); // Kebaya kuning keemasan
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(220, 170, 20); // Sulaman emas
  rect(-35, -115, 70, 10);
  rect(-35, -95, 70, 10);

  // Sarung tenun Bugis bermotif kotak (motif boti)
  fill(150, 50, 100); // Merah keunguan
  rect(-50, 30, 100, 100, 5);
  // Motif kotak
  stroke(0);
  strokeWeight(0.5);
  for (int i = -40; i < 40; i += 15) {
    line(i, 40, i, 120);
    line(-50, i + 80, 50, i + 80);
  }
  noStroke();

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut panjang mengalir (tidak menutupi muka)
  fill(80, 40, 0); // Coklat gelap
  beginShape();
  vertex(-20, -150); // Puncak kepala, sisi kiri
  bezierVertex(-30, -160, -45, -120, -40, -50); // Aliran sisi kiri
  bezierVertex(-35, 0, -20, 20, -10, 40); // Terus ke bawah
  vertex(10, 40); // Tengah bawah
  bezierVertex(20, 20, 35, 0, 40, -50); // Aliran sisi kanan
  bezierVertex(45, -120, 30, -160, 20, -150); // Puncak kepala, sisi kanan
  endShape(CLOSE);

  // Wajah: Wajah oval, alis halus, tatapan lembut
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 3, 3); // Mata kiri
    ellipse(8, -135, 3, 3); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  point(0, -128); // Hidung kecil
  noFill();
  stroke(0);
  strokeWeight(0.5);
  line(-10, -140, 10, -140); // Alis halus
  if (isTalking) {
    arc(0, -125, 10, 8, 0, PI); // Mulut berbicara
  } else {
    arc(0, -125, 10, 5, 0, PI); // Mulut lembut
  }

  // Aksesori: Anting besar bulat, kalung mutiara lokal
  fill(180, 180, 180); // Warna mutiara
  ellipse(-30, -110, 10, 10); // Anting kiri
  ellipse(30, -110, 10, 10); // Anting kanan
  ellipse(0, -100, 5, 5); // Kalung mutiara
  ellipse(-8, -102, 5, 5);
  ellipse(8, -102, 5, 5);

  // Lengan dan tangan
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  popMatrix();
}

void drawHeart(float x, float y, float size) {
  beginShape();
  vertex(x, y - size * 0.4);
  bezierVertex(x + size * 0.5, y - size * 1.2, x + size * 1.5, y - size * 0.4, x, y + size * 0.8);
  bezierVertex(x - size * 1.5, y - size * 0.4, x - size * 0.5, y - size * 1.2, x, y - size * 0.4);
  endShape(CLOSE);
}

void drawSawerigadingChild(float x, float y, float scaleFactor, boolean lookingAtBox) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (bertelanjang dada, sarung kecil)
  fill(200, 160, 120); // Warna kulit
  beginShape();
  vertex(-20, -80);
  vertex(20, -80);
  vertex(25, 0);
  vertex(-25, 0);
  endShape(CLOSE); // Torso
  fill(100, 70, 30); // Sarung
  rect(-30, 0, 60, 50, 5);

  // Kepala
  fill(200, 160, 120);
  ellipse(0, -90, 40, 40);

  // Rambut pendek berponi
  fill(30, 20, 0); // Coklat gelap
  beginShape();
  vertex(-20, -110);
  bezierVertex(-25, -115, -20, -100, -15, -95);
  bezierVertex(-5, -90, 5, -90, 15, -95);
  bezierVertex(20, -100, 25, -115, 20, -110);
  endShape(CLOSE);
  rect(-15, -105, 30, 10); // Poni

  // Wajah: Mata besar ingin tahu
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -95, 8, -95); // Mata tertutup
  } else {
    ellipse(-8, -95, 5, 5); // Mata kiri
    ellipse(8, -95, 5, 5); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-3, -90, 3, -90, 0, -87); // Hidung
  noFill();
  stroke(0);
  if (isTalking) {
    arc(0, -85, 10, 8, 0, PI); // Mulut berbicara
  } else {
    arc(0, -85, 10, 5, 0, PI); // Mulut
  }

  // Kalung manik-manik kecil
  fill(180, 180, 180);
  ellipse(0, -60, 5, 5);
  ellipse(-8, -62, 5, 5);
  ellipse(8, -62, 5, 5);

  // Tangan (melihat kotak)
  fill(200, 160, 120); // Warna kulit
  rect(-25, -60, 10, 30); // Lengan kiri
  rect(15, -60, 10, 30); // Lengan kanan
  ellipse(-20, -30, 15, 15); // Tangan kiri
  ellipse(20, -30, 15, 15); // Tangan kanan

  if (lookingAtBox) {
    pushMatrix();
    translate(0, -50);
    rotate(radians(-30));
    fill(200, 160, 120);
    rect(0, 0, 10, 30); // Lengan
    ellipse(5, 30, 10, 10); // Tangan
    popMatrix();
  }

  popMatrix();
}

void drawWeTenriabengChild(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (kebaya lengan pendek anak-anak)
  fill(255, 200, 220); // Merah muda
  beginShape();
  vertex(-25, -80);
  vertex(25, -80);
  vertex(25, -10);
  vertex(-25, -10);
  endShape(CLOSE); // Torso

  // Sarung kecil bermotif bunga
  fill(150, 200, 150); // Hijau muda
  rect(-30, -10, 60, 60, 5);
  // Motif bunga
  fill(255, 100, 100);
  ellipse(-15, 10, 10, 10);
  ellipse(15, 20, 10, 10);

  // Kepala
  fill(200, 160, 120);
  ellipse(0, -90, 40, 40);

  // Rambut dikepang dua
  fill(80, 40, 0);
  beginShape(); // Kepang kiri
  vertex(-20, -110);
  bezierVertex(-25, -100, -20, -80, -30, -60);
  bezierVertex(-40, -40, -30, -20, -20, 0);
  endShape(CLOSE);
  beginShape(); // Kepang kanan
  vertex(20, -110);
  bezierVertex(25, -100, 20, -80, 30, -60);
  bezierVertex(40, -40, 30, -20, 20, 0);
  endShape(CLOSE);

  // Wajah: Wajah bundar
  fill(0); // Mata
  if (isBlinking) {
    line(-7, -95, 7, -95); // Mata tertutup
  } else {
    ellipse(-7, -95, 3, 3); // Mata kiri
    ellipse(7, -95, 3, 3); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  point(0, -90); // Hidung
  noFill();
  stroke(0);
  if (isTalking) {
    arc(0, -85, 8, 6, 0, PI); // Mulut berbicara
  } else {
    arc(0, -85, 8, 4, 0, PI); // Mulut
  }

  // Tangan memegang bunga
  fill(200, 160, 120);
  rect(10, -50, 10, 30); // Lengan
  ellipse(15, -20, 10, 10); // Tangan
  fill(255, 100, 100); // Bunga
  ellipse(15, -15, 15, 15);

  // Aksesori: Gelang rotan kecil
  fill(100, 70, 30);
  ellipse(15, -30, 8, 8);

  // Kaki
  fill(200, 160, 120); // Warna kulit
  rect(-10, 50, 10, 30); // Kaki kiri
  rect(0, 50, 10, 30); // Kaki kanan
  ellipse(-5, 80, 15, 8); // Kaki kiri
  ellipse(5, 80, 15, 8); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdult(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh: Pakaian panglima Bugis: baju bodo lengan panjang, armor tipis di dada
  fill(50, 30, 0); // Baju bodo gelap
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(150, 150, 150, 150); // Armor tipis
  rect(-30, -110, 60, 40, 5);

  // Ikat kepala tajori dari kain gelap, dililit ketat
  fill(20, 10, 0); // Hitam gelap
  ellipse(0, -140, 60, 30);
  rect(-25, -145, 50, 10);

  // Sarung lipat Bugis diikat di pinggang, warna gelap motif silang
  fill(30, 20, 0); // Sangat gelap
  rect(-50, 30, 100, 100, 5);
  // Motif silang
  stroke(50, 50, 50);
  strokeWeight(1);
  line(-40, 40, 40, 120);
  line(40, 40, -40, 120);
  noStroke();

  // Selendang perang di punggung, diikat menyilang
  fill(80, 0, 0); // Merah tua
  beginShape();
  vertex(-30, -100);
  vertex(30, -100);
  vertex(50, 50);
  vertex(-50, 50);
  endShape(CLOSE);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Rambut (pendek, gelap)
  fill(30, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah: Wajah tegas, dagu kokoh, mata tajam
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  noFill();
  stroke(0);
  strokeWeight(1);
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 15, 8, 0, PI); // Mulut tegas
  }
  line(-10, -128, 10, -128); // Alis

  // Aksesori: Pedang pendek terselip di pinggang, gelang logam
  fill(100, 100, 100); // Logam
  rect(40, 0, 10, 50); // Pedang
  triangle(40, 0, 45, -5, 50, 0); // Gagang pedang
  ellipse(35, -50, 8, 8); // Gelang

  // Lengan dan kaki
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  fill(50, 30, 0); // Warna celana
  rect(-20, 30, 15, 70); // Kaki kiri
  rect(5, 30, 15, 70); // Kaki kanan
  ellipse(-12.5, 100, 25, 10); // Kaki kiri
  ellipse(12.5, 100, 25, 10); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdultBack(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Pakaian panglima Bugis (dari belakang)
  fill(50, 30, 0); // Baju bodo gelap
  rect(-40, -120, 80, 150, 8);

  // Selendang perang di punggung, diikat menyilang
  fill(80, 0, 0); // Merah tua
  beginShape();
  vertex(-30, -100);
  vertex(30, -100);
  vertex(50, 50);
  vertex(-50, 50);
  endShape(CLOSE);

  // Kepala (dari belakang)
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);
  fill(30, 20, 0); // Rambut
  arc(0, -130, 50, 50, PI, TWO_PI);

  // Kaki
  fill(50, 30, 0);
  rect(-20, 30, 15, 70);
  rect(5, 30, 15, 70);
  ellipse(-12.5, 100, 25, 10); // Kaki kiri
  ellipse(12.5, 100, 25, 10); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdultDespair(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (membungkuk)
  fill(50, 30, 0);
  beginShape();
  vertex(-40, -80);
  vertex(40, -80);
  vertex(40, 20);
  vertex(-40, 20);
  endShape(CLOSE); // Torso

  // Kepala (tertunduk, wajah ditutupi tangan)
  fill(200, 160, 120);
  ellipse(0, -90, 50, 50);
  fill(30, 20, 0); // Rambut
  arc(0, -115, 60, 40, PI, TWO_PI);

  // Tangan menutupi wajah
  fill(200, 160, 120);
  pushMatrix();
  translate(-15, -80);
  rotate(radians(45));
  rect(0, 0, 10, 40); // Lengan
  ellipse(5, 40, 15, 15); // Tangan
  popMatrix();
  pushMatrix();
  translate(15, -80);
  rotate(radians(-45));
  rect(0, 0, 10, 40); // Lengan
  ellipse(5, 40, 15, 15); // Tangan
  popMatrix();

  // Kaki
  fill(50, 30, 0);
  rect(-20, 20, 15, 50);
  rect(5, 20, 15, 50);
  ellipse(-12.5, 70, 25, 10); // Kaki kiri
  ellipse(12.5, 70, 25, 10); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdultNewIdea(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (tegak)
  fill(50, 30, 0);
  rect(-40, -120, 80, 150, 8); // Torso

  // Kepala (terangkat)
  fill(200, 160, 120);
  ellipse(0, -130, 50, 50);
  fill(30, 20, 0); // Rambut
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah (semangat baru)
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  stroke(0);
  if (isTalking) {
    arc(0, -120, 15, 10, PI, TWO_PI); // Mulut berbicara (tersenyum)
  } else {
    arc(0, -120, 15, 8, PI, TWO_PI); // Mulut tersenyum
  }
  noStroke();

  // Tangan kanan menunjuk ke atas
  fill(200, 160, 120);
  pushMatrix();
  translate(30, -80);
  rotate(radians(-90)); // Menunjuk ke atas
  rect(0, 0, 10, 50); // Lengan
  ellipse(5, 50, 15, 15); // Tangan
  popMatrix();

  // Lengan kiri
  fill(200, 160, 120);
  rect(-50, -80, 10, 60);
  ellipse(-45, -20, 15, 15);

  // Kaki
  fill(50, 30, 0);
  rect(-20, 30, 15, 70);
  rect(5, 30, 15, 70);
  ellipse(-12.5, 100, 25, 10); // Kaki kiri
  ellipse(12.5, 100, 25, 10); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdultVowing(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh
  fill(50, 30, 0);
  rect(-40, -120, 80, 150, 8); // Torso

  // Kepala
  fill(200, 160, 120);
  ellipse(0, -130, 50, 50);
  fill(30, 20, 0); // Rambut
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  stroke(0);
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 15, 8, 0, PI); // Mulut serius
  }
  noStroke();

  // Tangan kanan ke dada bersumpah
  fill(200, 160, 120);
  pushMatrix();
  translate(30, -80);
  rotate(radians(20)); // Ke dada
  rect(0, 0, 10, 40); // Lengan
  ellipse(5, 40, 15, 15); // Tangan
  popMatrix();

  // Lengan kiri
  fill(200, 160, 120);
  rect(-50, -80, 10, 60);
  ellipse(-45, -20, 15, 15);

  // Kaki
  fill(50, 30, 0);
  rect(-20, 30, 15, 70);
  rect(5, 30, 15, 70);
  ellipse(-12.5, 100, 25, 10); // Kaki kiri
  ellipse(12.5, 100, 25, 10); // Kaki kanan

  popMatrix();
}

void drawSawerigadingAdultChopping(float x, float y, float scaleFactor, long elapsedTime) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh
  fill(50, 30, 0);
  rect(-40, -120, 80, 150, 8); // Torso

  // Kepala
  fill(200, 160, 120);
  ellipse(0, -130, 50, 50);
  fill(30, 20, 0); // Rambut
  beginShape();
  vertex(-20, -155);
  bezierVertex(-25, -160, -20, -145, -15, -135);
  bezierVertex(-5, -130, 5, -130, 15, -135);
  bezierVertex(20, -145, 25, -160, 20, -155);
  endShape(CLOSE);

  // Wajah
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4); // Mata kiri
    ellipse(8, -135, 4, 4); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-4, -128, 4, -128, 0, -123); // Hidung
  stroke(0);
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 15, 8, 0, PI); // Mulut serius
  }
  noStroke();

  // Tangan memegang kapak (animasi mengayun)
  float swingAngle = map(sin(elapsedTime * 0.01), -1, 1, -PI / 4, PI / 4);
  fill(200, 160, 120); // Warna kulit
  pushMatrix();
  translate(0, -80);
  rotate(swingAngle);
  rect(0, 0, 10, 60); // Lengan
  ellipse(5, 60, 15, 15); // Tangan
  // Kapak
  fill(100);
  rect(5, 60, 5, 50); // Gagang
  triangle(0, 100, 10, 100, 5, 90); // Mata kapak
  popMatrix();

  // Lengan kiri (diam)
  fill(200, 160, 120);
  rect(-50, -80, 10, 60);
  ellipse(-45, -20, 15, 15);

  // Kaki
  fill(50, 30, 0);
  rect(-20, 30, 15, 70);
  rect(5, 30, 15, 70);
  ellipse(-12.5, 100, 25, 10); // Kaki kiri
  ellipse(12.5, 100, 25, 10); // Kaki kanan

  popMatrix();
}

void drawWeTenriabengAdult(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Kebaya bangsawan Bugis: lengan panjang, hiasan emas di dada
  fill(255, 200, 220); // Merah muda cerah
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(220, 170, 20); // Hiasan emas
  rect(-30, -110, 60, 20, 5);

  // Sarung halus warna cerah
  fill(150, 200, 255); // Biru muda
  rect(-50, 30, 100, 100, 5);

  // Sanggul besar dihiasi tusuk konde
  fill(80, 40, 0); // Rambut coklat
  ellipse(0, -140, 70, 50); // Sanggul
  fill(180, 140, 80); // Tusuk konde
  rect(-5, -160, 10, 30);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Wajah: Wajah oval simetris, mata sendu
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 3, 3); // Mata kiri
    ellipse(8, -135, 3, 3); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  point(0, -128); // Hidung
  noFill();
  stroke(0);
  strokeWeight(0.5);
  line(-10, -140, 10, -140); // Alis
  if (isTalking) {
    arc(0, -125, 10, 8, 0, PI); // Mulut berbicara
  } else {
    arc(0, -125, 10, 5, 0, PI); // Mulut sendu
  }

  // Aksesori: Gelang emas, cincin besar, kalung 3 lapis
  fill(220, 170, 20); // Emas
  ellipse(-35, -70, 10, 10); // Gelang kiri
  ellipse(35, -70, 10, 10); // Gelang kanan
  ellipse(0, -20, 8, 8); // Cincin
  ellipse(0, -100, 5, 5); // Kalung
  ellipse(0, -95, 5, 5);
  ellipse(0, -90, 5, 5);

  // Lengan dan kaki
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  popMatrix();
}

void drawBataraLattu(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (jubah panjang warna gelap)
  fill(40, 20, 0); // Coklat sangat gelap
  beginShape();
  vertex(-50, -150);
  vertex(50, -150);
  vertex(50, 50);
  vertex(-50, 50);
  endShape(CLOSE); // Torso

  // Kain selempang berhias pola petir
  fill(100, 0, 0); // Merah gelap
  beginShape();
  vertex(-40, -100);
  vertex(40, -100);
  vertex(50, 50);
  vertex(-50, 50);
  endShape(CLOSE);
  // Pola petir
  stroke(255, 255, 0);
  strokeWeight(1);
  line(-20, -80, -10, -90);
  line(-10, -90, 0, -80);
  line(0, -80, 10, -90);
  line(10, -90, 20, -80);
  noStroke();

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 60, 60);

  // Janggut panjang
  fill(80, 80, 80); // Abu-abu
  beginShape();
  vertex(-15, -110);
  bezierVertex(-25, -70, -10, -30, 0, -10);
  bezierVertex(10, -30, 25, -70, 15, -110);
  endShape(CLOSE);

  // Wajah, mata tajam
  fill(0); // Mata
  if (isBlinking) {
    line(-10, -135, 10, -135); // Mata tertutup
  } else {
    ellipse(-10, -135, 5, 5); // Mata kiri
    ellipse(10, -135, 5, 5); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  triangle(-5, -128, 5, -128, 0, -123); // Hidung
  noFill();
  stroke(0);
  if (isTalking) {
    arc(0, -120, 20, 15, 0, PI); // Mulut berbicara
  } else {
    arc(0, -120, 20, 10, 0, PI); // Mulut serius
  }
  noStroke();

  // Aksesori: Tongkat kayu dengan ukiran berbentuk ular bertanduk
  stroke(100, 70, 30); // Kayu
  strokeWeight(8);
  line(60, -50, 70, 100);
  // Ukiran ular
  fill(50, 80, 0);
  ellipse(65, -40, 20, 20); // Kepala ular
  bezier(65, -40, 75, -30, 70, -20, 65, -10); // Tubuh ular
  popMatrix();
}

void drawTree(float x, float y, float trunkWidth, float trunkHeight) {
  fill(100, 70, 30); // Batang
  rect(x - trunkWidth / 2, y, trunkWidth, trunkHeight);
  fill(60, 120, 40); // Daun
  ellipse(x, y, trunkWidth * 2, trunkHeight * 1.5);
}

void drawFloweringTree(float x, float y, float trunkWidth, float trunkHeight) {
  drawTree(x, y, trunkWidth, trunkHeight);
  fill(255, 150, 200); // Bunga merah muda
  ellipse(x - trunkWidth * 0.5, y - trunkHeight * 0.3, 30, 30);
  ellipse(x + trunkWidth * 0.5, y - trunkHeight * 0.2, 35, 35);
  ellipse(x, y - trunkHeight * 0.4, 40, 40);
}

void drawCraftsman(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  fill(180, 140, 80); // Pakaian
  beginShape();
  vertex(-20, -60);
  vertex(20, -60);
  vertex(20, 20);
  vertex(-20, 20);
  endShape(CLOSE); // Torso
  fill(200, 160, 120); // Kulit
  ellipse(0, -70, 30, 30);
  fill(30, 20, 0); // Rambut
  rect(-15, -80, 30, 10);
  fill(0); // Mata
  if (isBlinking) {
    line(-5, -75, 5, -75); // Mata tertutup
  } else {
    ellipse(-5, -75, 2, 2);
    ellipse(5, -75, 2, 2);
  }
  stroke(0); // Mulut
  if (isTalking) {
    arc(0, -70, 10, 8, 0, PI); // Mulut berbicara
  } else {
    line(-5, -70, 5, -70);
  }
  noStroke();

  // Tangan memahat
  fill(200, 160, 120);
  pushMatrix();
  translate(10, -30);
  rotate(radians(45));
  rect(0, 0, 5, 20);
  ellipse(2.5, 20, 8, 8);
  popMatrix();

  // Kaki
  fill(180, 140, 80);
  rect(-10, 20, 10, 30);
  rect(0, 20, 10, 30);
  ellipse(-5, 50, 15, 8);
  ellipse(5, 50, 15, 8);

  popMatrix();
}

void drawBissu(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  fill(255, 255, 255); // Pakaian putih
  beginShape();
  vertex(-30, -80);
  vertex(30, -80);
  vertex(30, 20);
  vertex(-30, 20);
  endShape(CLOSE); // Torso
  fill(200, 160, 120); // Kulit
  ellipse(0, -90, 40, 40);
  fill(80, 80, 80); // Rambut
  arc(0, -90, 40, 40, PI, TWO_PI);
  fill(0); // Mata
  if (isBlinking) {
    line(-7, -95, 7, -95); // Mata tertutup
  } else {
    ellipse(-7, -95, 3, 3);
    ellipse(7, -95, 3, 3);
  }
  stroke(0); // Mulut
  if (isTalking) {
    arc(0, -85, 10, 8, 0, PI); // Mulut berbicara
  } else {
    line(-7, -85, 7, -85);
  }
  noStroke();

  // Tongkat ritual
  stroke(100, 70, 30);
  strokeWeight(3);
  line(20, -50, 30, 20);
  noStroke();

  // Kaki
  fill(255, 255, 255);
  rect(-15, 20, 10, 30);
  rect(5, 20, 10, 30);
  ellipse(-10, 50, 15, 8);
  ellipse(10, 50, 15, 8);

  popMatrix();
}

void drawEnemyWarrior(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  fill(80, 80, 80); // Armor
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(150, 0, 0); // Jubah
  rect(-30, -110, 60, 100);

  fill(200, 160, 120); // Kepala
  ellipse(0, -130, 50, 50);
  fill(30, 20, 0); // Rambut
  rect(-20, -150, 40, 20);

  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 4, 4);
    ellipse(8, -135, 4, 4);
  }
  stroke(0); // Mulut
  if (isTalking) {
    arc(0, -120, 15, 10, 0, PI); // Mulut berbicara
  } else {
    line(-10, -120, 10, -120);
  }
  noStroke();

  // Tombak
  stroke(100, 100, 100);
  strokeWeight(5);
  line(50, -100, 100, 50);
  fill(150, 150, 150);
  triangle(100, 50, 110, 40, 110, 60); // Ujung tombak
  noStroke();

  // Lengan dan kaki
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  popMatrix();
}

void drawPalmTree(float x, float y) {
  fill(100, 70, 30); // Batang
  rect(x - 10, y, 20, 100);
  fill(60, 120, 40); // Daun
  ellipse(x, y, 80, 80);
  triangle(x, y, x - 50, y - 50, x - 20, y - 80);
  triangle(x, y, x + 50, y - 50, x + 20, y - 80);
}

void drawWeCudaiq(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Pakaian: Kebaya perpaduan Bugis-Tionghoa dengan pola bunga lotus dan bordiran naga kecil
  fill(255, 180, 200); // Kebaya merah muda
  beginShape();
  vertex(-40, -120);
  vertex(40, -120);
  vertex(40, 30);
  vertex(-40, 30);
  endShape(CLOSE); // Torso
  fill(220, 170, 20); // Bordiran emas
  rect(-35, -115, 70, 10);
  rect(-35, -95, 70, 10);

  // Sarung sutra bermotif awan dan ombak
  fill(100, 150, 200); // Biru muda
  rect(-50, 30, 100, 100, 5);
  // Motif awan dan ombak (sederhana)
  fill(255, 255, 255, 100);
  ellipse(-30, 50, 20, 10);
  ellipse(30, 60, 20, 10);

  // Sanggul rendah dihiasi tusuk giok dan bunga kecil
  fill(80, 40, 0); // Rambut
  ellipse(0, -130, 60, 40); // Sanggul
  fill(100, 200, 100); // Tusuk giok
  rect(-5, -145, 10, 20);
  fill(255, 150, 200); // Bunga kecil
  ellipse(0, -140, 10, 10);

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -130, 50, 50);

  // Wajah: Mirip wajah We Tenriabéng, tapi lebih lembut dan bersahaja.
  fill(0); // Mata
  if (isBlinking) {
    line(-8, -135, 8, -135); // Mata tertutup
  } else {
    ellipse(-8, -135, 3, 3); // Mata kiri
    ellipse(8, -135, 3, 3); // Mata kanan
  }
  fill(100, 50, 0); // Warna kulit untuk hidung
  point(0, -128); // Hidung
  noFill();
  stroke(0);
  strokeWeight(0.5);
  line(-10, -140, 10, -140); // Alis
  if (isTalking) {
    arc(0, -125, 10, 8, PI, TWO_PI); // Mulut berbicara (senyum lembut)
  } else {
    arc(0, -125, 10, 5, PI, TWO_PI); // Senyum lembut
  }

  // Aksesori: Anting panjang berbentuk tetes air, kalung batu hijau zamrud
  fill(100, 200, 100); // Zamrud
  ellipse(-30, -100, 8, 15); // Anting kiri
  ellipse(30, -100, 8, 15); // Anting kanan
  ellipse(0, -110, 10, 10); // Kalung

  // Lengan dan kaki
  fill(200, 160, 120); // Warna kulit
  rect(-50, -100, 10, 60); // Lengan kiri
  rect(40, -100, 10, 60); // Lengan kanan
  ellipse(-45, -40, 15, 15); // Tangan kiri
  ellipse(45, -40, 15, 15); // Tangan kanan

  popMatrix();
}

void drawWeCudaiqHoldingBaby(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  drawWeCudaiq(0, 0, 1.0); // Gambar We Cudaiq

  // Bayi La Galigo
  fill(255, 240, 220); // Kulit cerah
  ellipse(-30, 50, 40, 60); // Tubuh bayi
  fill(200, 160, 120); // Kepala bayi
  ellipse(-30, 30, 30, 30);
  fill(0); // Mata
  ellipse(-35, 25, 2, 2);
  ellipse(-25, 25, 2, 2);
  stroke(0); // Mulut
  arc(-30, 28, 5, 3, PI, TWO_PI);
  noStroke();

  // Kain tenun lembut yang membungkus seluruh tubuh
  fill(180, 140, 80); // Coklat muda
  rect(-45, 40, 70, 70, 5);
  // Motif garis-garis ringan
  stroke(100, 70, 30);
  strokeWeight(0.5);
  line(-40, 45, 20, 45);
  line(-40, 55, 20, 55);
  noStroke();

  popMatrix();
}

void drawLaGaligoToddler(float x, float y, float scaleFactor) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  // Tubuh (baju lengan pendek tradisional dari kain tenun, polos)
  fill(150, 100, 50); // Coklat terang
  beginShape();
  vertex(-20, -50);
  vertex(20, -50);
  vertex(20, 0);
  vertex(-20, 0);
  endShape(CLOSE); // Torso

  // Sarung kecil bermotif silang
  fill(100, 70, 30); // Coklat gelap
  rect(-25, 0, 50, 40, 5);
  // Motif silang
  stroke(50, 50, 50);
  strokeWeight(0.5);
  line(-20, 5, 15, 30);
  line(15, 5, -20, 30);
  noStroke();

  // Kepala
  fill(200, 160, 120); // Warna kulit
  ellipse(0, -60, 35, 35);

  // Wajah bulat, rambut ikal pendek, sorot mata tajam seperti ayahnya
  fill(30, 20, 0); // Rambut ikal
  ellipse(-10, -75, 15, 15);
  ellipse(10, -75, 15, 15);
  ellipse(0, -70, 20, 10);

  fill(0); // Mata
  ellipse(-6, -65, 3, 3); // Mata kiri
  ellipse(6, -65, 3, 3); // Mata kanan
  fill(100, 50, 0); // Warna kulit untuk hidung
  point(0, -60); // Hidung
  noFill();
  stroke(0);
  arc(0, -55, 10, 5, PI, TWO_PI); // Mulut tersenyum

  // Kalung manik kecil melingkar di leher
  fill(180, 180, 180);
  ellipse(0, -40, 5, 5);
  ellipse(-5, -42, 5, 5);
  ellipse(5, -42, 5, 5);

  // Lengan dan kaki
  fill(200, 160, 120); // Warna kulit
  rect(-20, -30, 10, 20); // Lengan kiri
  rect(10, -30, 10, 20); // Lengan kanan
  ellipse(-15, -10, 10, 10); // Tangan kiri
  ellipse(15, -10, 10, 10); // Tangan kanan

  popMatrix();
}

void drawShip(float x, float y, float scaleFactor, boolean unfurledSail) {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  float shipWidth = 400;
  float shipHeight = 150;

  // Lambung (lebih melengkung)
  fill(120, 90, 60); // Coklat kayu
  beginShape();
  vertex(-shipWidth / 2, 0);
  bezierVertex(-shipWidth / 2 - 20, 50, -shipWidth / 2 + 50, shipHeight, 0, shipHeight);
  bezierVertex(shipWidth / 2 - 50, shipHeight, shipWidth / 2 + 20, 50, shipWidth / 2, 0);
  endShape(CLOSE);

  // Dek
  fill(150, 110, 60);
  rect(-shipWidth / 2 + 20, -20, shipWidth - 40, 40, 5);

  // Tiang
  fill(100, 70, 30);
  rect(-10, -150, 20, 130);

  // Layar
  if (unfurledSail) {
    fill(200, 200, 200);
    float sailWave = sin(millis() * 0.003) * 10;
    beginShape();
    vertex(-10, -150);
    vertex(10, -150);
    bezierVertex(10 + sailWave, -50, -10 + sailWave, -50, -10, -150); // Gelombang sederhana
    endShape(CLOSE);
  } else {
    fill(200, 200, 200);
    ellipse(0, -100, 50, 100); // Layar tergulung
  }

  // Ukiran kepala naga di haluan
  fill(150, 0, 0); // Merah naga
  beginShape();
  vertex(-shipWidth / 2 - 30, -20);
  bezierVertex(-shipWidth / 2 - 50, -80, -shipWidth / 2 + 20, -100, -shipWidth / 2 + 50, -50);
  bezierVertex(-shipWidth / 2 + 30, -20, -shipWidth / 2 - 10, -10, -shipWidth / 2 - 30, -20);
  endShape(CLOSE);
  fill(0);
  ellipse(-shipWidth / 2 + 30, -60, 10, 10); // Mata naga

  popMatrix();
}

void drawWaves(float offset) {
  fill(60, 130, 180); // Biru lebih gelap untuk ombak dalam
  noStroke();
  for (float x = -width; x < width * 2; x += 50) {
    float y1 = height * 0.9 + sin((x + offset) * 0.01) * 20;
    float y2 = height * 0.95 + cos((x + offset) * 0.015) * 15;
    ellipse(x, y1, 100, 30);
    ellipse(x + 25, y2, 80, 25);
  }

  fill(80, 150, 200); // Biru lebih terang untuk ombak permukaan
  for (float x = -width; x < width * 2; x += 70) {
    float y1 = height * 0.85 + sin((x + offset * 0.8) * 0.012) * 15;
    float y2 = height * 0.88 + cos((x + offset * 0.8) * 0.01) * 10;
    ellipse(x, y1, 120, 40);
    ellipse(x + 35, y2, 100, 35);
  }
}

void drawSubtitle() {
  fill(255, 255, 255, 200); // Putih, semi-transparan
  noStroke();
  rect(0, height - 60, width, 60); // Latar belakang persegi panjang untuk subtitle

  fill(0); // Teks hitam
  textSize(20);
  textAlign(CENTER, CENTER);
  text(subtitles[currentFrame - 1], width / 2, height - 30);
}
