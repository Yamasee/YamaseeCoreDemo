
# create folder where we place built frameworks
mkdir build
# build framework for simulators
xcodebuild clean build \
  -project Yamasee.xcodeproj \
  -scheme Yamasee \
  -configuration Release \
  -sdk iphonesimulator \
  -derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/simulator
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/Yamasee.framework build/simulator
#build framework for devices
xcodebuild clean build \
  -project Yamasee.xcodeproj \
  -scheme Yamasee \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/devices
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/Yamasee.framework build/devices
# create folder to store compiled universal framework
mkdir build/universal
####################### Create universal framework #############################
# copy device framework into universal folder
cp -r build/devices/Yamasee.framework build/universal/
# create framework binary compatible with simulators and devices, and replace binary in unviersal framework
lipo -create \
  build/simulator/Yamasee.framework/Yamasee \
  build/devices/Yamasee.framework/Yamasee \
  -output build/universal/Yamasee.framework/Yamasee
# copy simulator Swift public interface to universal framework
cp build/simulator/Yamasee.framework/Modules/Yamasee.swiftmodule/* build/universal/Yamasee.framework/Modules/Yamasee.swiftmodule
