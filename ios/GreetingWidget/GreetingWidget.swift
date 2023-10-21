//
//  GreetingWidget.swift
//  GreetingWidget
//
//  Created by Jan Armbrust on 11.10.23.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> GreetingEntry {
        GreetingEntry(date: Date(), name: "Placeholder Name", greeting: "Placeholder Greeting")
    }

    func getSnapshot(in context: Context, completion: @escaping (GreetingEntry) -> ()) {
        let entry: GreetingEntry
        if context.isPreview {
            entry = placeholder(in: context)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.flutterioswidgetsdemoflutterhamburgmeetup")
            let name = userDefaults?.string(forKey: "greeting_name") ?? "No Name Set"
            let greeting = userDefaults?.string(forKey: "greeting_greeting") ?? "No Greeting Set"
            entry = GreetingEntry(date: Date(), name: name, greeting: greeting)
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

struct GreetingEntry: TimelineEntry {
    let date: Date
    let name: String
    let greeting: String
}

struct GreetingWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.greeting)
            Text(entry.name)
        }
    }
}

struct GreetingWidget: Widget {
    let kind: String = "GreetingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                GreetingWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                GreetingWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Greeting Widget")
        .description("This is an example greeting widget.")
    }
}

#Preview(as: .systemSmall) {
    GreetingWidget()
} timeline: {
    GreetingEntry(date: .now, name: "Flutter Hamburg ⚓️", greeting: "Moin")
    GreetingEntry(date: .now, name: "Jan", greeting: "Hallo")
}
