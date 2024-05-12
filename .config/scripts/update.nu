let CORES = nproc

echo "[FEDORA]"
sudo dnf distro-sync -yq
    
echo "\n[JAVA]"
cd ~/Packages/java
git pull -q
mvn install -DskipTests=true -T $CORES -q

echo "\n[KOTLIN]"
cd ~/Packages/kotlin
git pull -q
./gradlew :server:installDist -q

echo "\n[ZELLIJ]"
cd ~/Packages/zellij
git pull -q
RUSTFLAGS=-Awarnings cargo install -q --path .
