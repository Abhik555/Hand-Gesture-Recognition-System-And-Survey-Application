![ICON](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/blob/main/icon.png?raw=true)

# Hand Gesture Recognition System and Survey Application

Image classification is a fundamental task in computer vision with applications spanning autonomous vehicles, healthcare, and security systems. The development of deep learning models, particularly Convolutional Neural Networks (CNNs), has significantly improved classification accuracy. This report discusses an image classification project using a CNN architecture on the Hagrid 150k dataset, exploring existing research and external findings to contextualize and validate the approach.

This purpose of this project is to compare custom classification CNN architecture with standard models used for most research applications in this field and utilize a mobile app-based survey to find the perfect balance between complexity and accuracy for gesture recognition.

![GitHub Repo stars](https://img.shields.io/github/stars/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application)

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Application](#application)
  - [Screenshots](#screenshots)
  - [Installation](#installation)
  - [Contribute](#contribute)
  - [LICENSE](#license)
- [Model Training](#training)
  - [Dataset](#dataset)
  - [Preprocessing](#preprocessing)
  - [Model Architecture](#model-architecture)
  - [Training](#training)
  - [Evaluation](#evaluation)
  - [Results](#results)
  - [Conclusion](#conclusion)
- [Future Work](#future-work)
- [References](#references)

## Introduction

Hand gesture recognition is a crucial aspect of human-computer interaction. This project aims to build and test multiple model to classify hand gestures using the Hagrid dataset and determine the most practical model through mass survey.

## Usage

- Train Model Locally

  - Prerequisits

  ```python
  pip install tensorflow kaggle matplotlib PIL
  ```

  - Run and execute all the cells of the .ipynb file.



- Build Mobile App Locally

  - Prerequisits



  ```dart
  Flutter:3.5.3
  ```

  - Building the app



  ```cmd
  git clone https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application.git
  cd Hand-Gesture-Recognition-System-And-Survey-Application
  cd Gesture App/gestureapp
  flutter run
  ```





# Application

![ICON](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/blob/main/icon.png?raw=true)

A Companion Survey App to run and test and aquire feedback for evaluating Model Performance.

![Built in Flutter](https://img.shields.io/badge/Built%20in-Flutter-%23369FE7)

[![Hits-of-Code](https://hitsofcode.com/github/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application?branch=main)](https://hitsofcode.com/github/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/view?branch=main)

![Lines of Code](https://tokei.rs/b1/github/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application)

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/total)


## Screenshots

![SHOT1](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/blob/main/screenshots/pic1.jpg?raw=true)
![SHOT1](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/blob/main/screenshots/pic2.jpg?raw=true)
![SHOT1](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/blob/main/screenshots/pic3.jpg?raw=true)

## Installation

Download .apk file from releases

[Releases](https://github.com/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application/releases/)

## Contribute

- Fork it and make it your own
- Improve the application and add to the repo
- Dont forget to star the repo

## License

![GitHub License](https://img.shields.io/github/license/Abhik555/Hand-Gesture-Recognition-System-And-Survey-Application)


# Training

## Dataset

The Hagrid 150k dataset is a comprehensive collection of hand gesture images. It includes various gestures captured under different lighting conditions and backgrounds.

[Dataset](https://www.kaggle.com/datasets/innominate817/hagrid-classification-512p-no-gesture-150k)

## Preprocessing

- Resize image: change image size to 256x256 to retain as much detail as possible
- Random Rotation: Randomly rotating the images to make the model invariant to the orientation of the hand gestures.
- Random Zoom: Randomly zooming into the images to help the model recognize gestures at different scales.
- Random Flipping: Randomly flipping the images horizontally to augment the dataset with mirrored versions of the gestures.
- Image Rescaling: Rescaling the pixel values of the images to the range [0, 1] by dividing by 255.

## Model Architecture

The model used in this project is a Convolutional Neural Network (CNN) designed to handle image classification tasks. The architecture includes:

### Simple CNN

- Conv2D: 16 filters, activation 'relu', input shape (256, 256, 3)
- MaxPooling2D: pool size 2x2
- Conv2D: 32 filters, activation 'relu'
- MaxPooling2D: pool size 2x2
- Conv2D: 64 filters, activation 'relu'
- MaxPooling2D: pool size 2x2
- Dropout
- Flatten
- Dense: 128 units, activation 'relu'
- Dense: 10 units, activation 'softmax'

### Complex CNN

- Conv2D(32, (3, 3), activation='relu', padding='same')
- BatchNormalization()
- MaxPooling2D((2, 2))
- Dropout(0.25)
- Conv2D(64, (3, 3), activation='relu', padding='same')
- BatchNormalization()
- MaxPooling2D((2, 2))
- Dropout(0.25)
- Conv2D(128, (3, 3), activation='relu', padding='same')
- BatchNormalization()
- MaxPooling2D((2, 2))
- Dropout(0.25)
- Flatten()
- Dense(256, activation='relu')
- BatchNormalization()
- Dropout(0.5)
- Dense(num_classes, activation='softmax', name="outputs")

## Model Training

The model was trained using the following parameters:

- Optimizer: Adam
- Loss Function: SparseCategoricalCrossentropy
- Epochs: 15
- Batch Size: 128

## Evaluation

The model was evaluated using a separate validation set. The performance metrics used include accuracy, precision, recall, and F1-score.

## Results

The final model achieved the following results on the validation set

### Simple CNN Metrics

- Accuracy: 82%
- Precision: 80%
- Recall: 79%
- F1-score: 80%

#### Simple Model Size

- keras file: 96.4 MB
- tflite: 32.1 MB

### Complex CNN Metrics

- Accuracy: 74%
- Precision: 72%
- Recall: 71%
- F1-score: 71%

#### Complex Model Size

- keras file: 385 MB
- tflite: 128 MB

### Compareable ResNET50 Model

- Accuracy: 93%
- Precision: 93%
- Recall: 92%
- F1-score: 92%

#### ResNET50 Model Size

- keras file: 271 MB
- tflite: 89.8 MB

### Trained Model Files can be downloaded from releases

## Conclusion

The hand gesture detection model developed in this project demonstrates varying results from multiple model architectures. It can be effectively used for comparision.

## Future Work

Future improvements could include:

- Expanding the dataset with more diverse gestures
- Implementing mobile app based survey to allow user review for model performance
- Enhancing the model architectures for better performance

- Add the ability to test user made model on the mobile app
- User Customizable Surveys

## References

- Convolutional Neural Networks: [Paper](https://openaccess.thecvf.com/content/WACV2024/html/Kapitanov_HaGRID_--_HAnd_Gesture_Recognition_Image_Dataset_WACV_2024_paper.html)
