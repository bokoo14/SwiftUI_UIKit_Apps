//
//  VoiceRecorderView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/26/23.
//

import SwiftUI

struct VoiceRecorderView: View {
    @StateObject private var voiceRecorderViewModel = VoiceRecorderViewModel()
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                TitleView()
                // 안내뷰
                if voiceRecorderViewModel.recordedFiles.isEmpty {
                    AnnouncementView()
                } else {
                    VoiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
                        .padding(.top, 15)
                }
                Spacer()
            } // VStack
           
            
            // 보이스 레코더 리스트 뷰
            RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
            // 녹음버튼 뷰
        }
        .alert("선택된 음성메모를 삭제하시겠습니까?", 
               isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorderAlert
        ) {
            Button("삭제", role: .destructive) {
                voiceRecorderViewModel.removeSelectedVoiceRecord()
            }
            Button("취소", role: .cancel ) { }
        }
        .alert(voiceRecorderViewModel.alertMessage,
               isPresented: $voiceRecorderViewModel.isDisplayAlert
        ) {
            Button("확인", role: .cancel) {
            }
        } // alert
        // recordedFiles의 값이 변경될때마다 개수를 받아와서 업데이트
        .onChange(of: voiceRecorderViewModel.recordedFiles) { recordedFiles in
            homeViewModel.setVoiceRecordersCount(recordedFiles.count)
        } // onChange
    }
}


// MARK: 타이틀 뷰
// MARK: private을 하는 이유, fileprivate을 하는 이유, init을 하는 이유?
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("음성메모")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.customBlack)
            Spacer()
        } // HStack
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

// MARK: 음성메모 안내 뷰
private struct AnnouncementView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(.customCoolGray)
                .frame(height: 1)
            
            Spacer()
                .frame(height: 180)
            
            Image("pencil")
                .renderingMode(.template)
            
            Text("현재 등록된 음성메모가 없습니다.")
            Text("하단의 녹음 버튼을 눌러 음성메모를 시작해주세요.")
            
            Spacer()
        } // VStack
        .font(.system(size: 16))
        .foregroundStyle(.customGray2)
    }
}

// MARK: 음성메모 리스트 뷰
private struct VoiceRecorderListView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    fileprivate var body: some View {
        ScrollView(.vertical) {
            VStack {
                Rectangle()
                    .fill(.customGray2)
                    .frame(height: 1)
                
                ForEach(voiceRecorderViewModel.recordedFiles, id: \.self) { recordedFile in
                    // 음성메모 셀 뷰 호출
                    VoiceRecorderCellView(voiceRecorderViewModel: voiceRecorderViewModel, recordedFile: recordedFile)
                }
            }
        }
    }
}

// MARK: 음성메모 셀 뷰
private struct VoiceRecorderCellView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    private var recordedFile: URL
    private var creationDate: Date?
    private var duration: TimeInterval?
    private var progressBarValue: Float {
        if voiceRecorderViewModel.selectedRecordedFile == recordedFile && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused) {
            return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
        } else {
            return 0
        }
    }
    
    fileprivate init(
        voiceRecorderViewModel: VoiceRecorderViewModel,
        recordedFile: URL
    ) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
        self.recordedFile = recordedFile
        (self.creationDate, self.duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile)
    }
    
    fileprivate var body: some View {
        VStack {
            Button(
                action: {
                    voiceRecorderViewModel.voiceRecordCellTapped(recordedFile)
                },
                label: {
                    VStack {
                        HStack {
                            Text(recordedFile.lastPathComponent)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.customBlack)
                            Spacer()
                        } // HStack
                        
                        Spacer()
                            .frame(height: 5)
                        
                        HStack {
                            if let creationDate = creationDate {
                                Text(creationDate.formattedVoiceRecorderTime)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.customIconGray)
                            }
                            Spacer()
                            if voiceRecorderViewModel.selectedRecordedFile != recordedFile, let duration = duration {
                                Text(duration.formattedTimeInterval)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.customIconGray)
                            }
                        } // HStack
                    } // VStack
                }) // Button
            .padding(.horizontal, 20)
            
            // 하단의 재생 Areea
            if voiceRecorderViewModel.selectedRecordedFile == recordedFile {
                VStack {
                    // 프로그래스 바
                    ProgressBar(progress: progressBarValue)
                        .frame(height: 2)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack {
                        Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.customIconGray)
                        Spacer()
                        if let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.customIconGray)
                        }
                    } // HStack
                    
                    Spacer()
                        .frame(height: 10)
                    
                    HStack {
                        Spacer()
                        // 재생버튼
                        Button(action: {
                            if voiceRecorderViewModel.isPaused {
                                voiceRecorderViewModel.resumePlaying()
                            } else {
                                voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
                            }
                        }, label: {
                            // TODO: 렌더링모드를 해주는 이유는?
                            Image("play")
                                .renderingMode(.template)
                                .foregroundStyle(.customBlack)
                        })
                        
                        Spacer()
                            .frame(width: 10)
                        
                        // 일시정지 및 다시 재생버튼
                        Button(action: {
                            if voiceRecorderViewModel.isPlaying {
                                voiceRecorderViewModel.pausePlaying()
                            }
                        }, label: {
                            Image("pause")
                                .renderingMode(.template)
                                .foregroundStyle(.customBlack)
                        })
                        
                        Spacer()
                        
                        // 삭제버튼
                        Button(action: {
                            voiceRecorderViewModel.removeBtnTapped()
                        }, label: {
                            Image("trash")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.customBlack)
                        })
                    }
                } // VStack
                .padding(.horizontal, 20)
            }
            
            Rectangle()
                .fill(.customGray2)
                .frame(height: 1)
        } // VStack
    }
}

// MARK: 프로그래스 바
private struct ProgressBar: View {
    private var progress: Float
    
    fileprivate init(progress: Float) {
        self.progress = progress
    }
    
    fileprivate var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.customGray2)
                
                Rectangle()
                    .fill(.customGreen)
                    .frame(width: max(min(0, CGFloat(self.progress) * geometry.size.width), 100))
            } // ZStack
        } // GeometryReader
    }
}

// MARK: 녹음 버튼 뷰
private struct RecordBtnView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    voiceRecorderViewModel.recordBtnTapped()
                }, label: {
                    if voiceRecorderViewModel.isRecording {
                        Image("mic_recording")
                    } else {
                        Image("mic")
                    }
                })
            } // HStack
        } // VStack
    }
}


#Preview {
    VoiceRecorderView()
}
