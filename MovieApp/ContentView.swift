//
//  ContentView.swift
//  MovieApp
//
//  Created by Aryan Jagarwal on 06/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MovieDBViewModel()
//    static let apiKey = "15853242b7cd782fc6c08c74df59e27c"
//    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTg1MzI0MmI3Y2Q3ODJmYzZjMDhjNzRkZjU5ZTI3YyIsInN1YiI6IjYxZDJmNmFjOGMyMmMwMDA0MTM5ZDQ2OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sZy_DJ-5fsIPirngSWzGC1q1cqNlM5FyNuksKXd3oes"
    
    //https://api.themoviedb.org/3/movie/550?api_key=15853242b7cd782fc6c08c74df59e27c
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=15853242b7cd782fc6c08c74df59e27c
    
    
    var body: some View {
        VStack {
            
        }
        .padding()
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

@MainActor
class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [TrendingItem] = []
    static let apiKey = "15853242b7cd782fc6c08c74df59e27c"
    
    //https://api.themoviedb.org/3/movie/550?api_key=15853242b7cd782fc6c08c74df59e27c
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=15853242b7cd782fc6c08c74df59e27c
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    

}

struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
}

struct TrendingItem:Identifiable, Decodable {
    
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
