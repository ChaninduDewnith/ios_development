//
//  RootTabView.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//
import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "gamecontroller.fill")
            }

            NavigationStack {
           
            }
            .tabItem {
                Label("Stats", systemImage: "chart.bar.fill")
            }

            NavigationStack {
                
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }

            NavigationStack {
             
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}

