//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Jan Armbrust on 12.10.23.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), sfSymbol: "arrow.clockwise", condition: "Placeholder Condition", temperature: "45 °C")
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry: WeatherEntry
        if context.isPreview {
            entry = placeholder(in: context)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.flutterioswidgetsdemoflutterhamburgmeetup")
            let sfSymbol = userDefaults?.string(forKey: "weather_sfsymbol") ?? "No SF Symbol Set"
            let condition = userDefaults?.string(forKey: "weather_condition") ?? "No Condition Set"
            let temperature = userDefaults?.string(forKey: "weather_temperature") ?? "No Temperature Set"
            entry = WeatherEntry(date: Date(), sfSymbol: sfSymbol, condition: condition, temperature: temperature)
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let sfSymbol: String
    let condition: String
    let temperature: String
}

struct WeatherWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: entry.sfSymbol)
                .font(.system(size: 60))
                .foregroundColor(.white)

            Text(entry.condition)
                .font(.headline)
                .foregroundColor(.white)

            Text(entry.temperature)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .widgetBackground(backgroundView: backgroundForCondition(entry.condition))
        }
        .configurationDisplayName("Weather Widget")
        .description("This is an example weather widget.")
    }

    func backgroundForCondition(_ condition: String) -> some View {
        switch condition {
        case "Sunny":
            return AnyView(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .top, endPoint: .bottom)).edgesIgnoringSafeArea(.all))
        case "Rainy":
            return AnyView(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .top, endPoint: .bottom)).edgesIgnoringSafeArea(.all))
        case "Cloudy":
            return AnyView(Rectangle().fill(Color.gray.opacity(0.5)).edgesIgnoringSafeArea(.all))
        default:
            return AnyView(Rectangle().fill(Color.blue).edgesIgnoringSafeArea(.all))
        }
    }
}

extension View {
    func widgetBackground(backgroundView: some View) -> some View {
        if #available(watchOS 10.0, iOSApplicationExtension 17.0, iOS 17.0, macOSApplicationExtension 14.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, sfSymbol: "sun.max", condition: "Sunny", temperature: "28 °C")
}
