# TripMate
TripMate is a vacation planner app where users can track their trips by logging daily energy and activity levels, adding notes, and organizing everything by vacation and day.

## Inspiration
We were inspired by the challenge of keeping track of personal experiences and energy levels while traveling. Often, travelers forget important details about their trips, from daily activities to how energized they felt. We wanted to create a simple, interactive app that allows users to log and reflect on their vacations day by day, creating a digital memory of their experiences.

## What it does
TripMate allows users to plan vacations by specifying the number of days, track their energy and activity levels on a 1–10 scale, and write and manage notes for each day. Users can add, edit, and delete entries for trips, daily activities, and notes, keeping all information organized by vacation. Essentially, the app serves as a digital travel diary, helping users reflect on and plan their trips more effectively.

## How we built it
The app was built entirely using SwiftUI to create a clean, interactive, and responsive interface. Each vacation is represented with a dynamic data model containing days, energy levels, activity levels, notes, and to-dos. Interactive controls such as sliders and segmented pickers were used for selecting days and entering energy and activity levels, while editable lists allow users to manage their notes. Navigation links were implemented so that each vacation on the home screen leads to a detailed view of the daily entries.

## Challenges we ran into
One of the main challenges was managing dynamic, nested data for multiple vacations and days without overwriting entries. Designing a user-friendly layout that can display all this information without becoming cluttered was also difficult. Additionally, we aimed to make the app fully functional without relying on external databases, which required careful handling of in-memory data structures to allow editing and deletion.

## Accomplishments that we're proud of
We are proud to have created a fully functional, self-contained vacation tracking app. The interface is interactive and visually appealing, and it scales well as more trips and days are added. The day-by-day tracking system for energy, activity, and notes allows users to fully customize and manage their travel experiences.

## What we learned
Through building TripMate, we learned how to effectively use @State and @Binding to manage dynamic, nested data in SwiftUI. We gained experience in building interactive, data-driven interfaces and learned how to structure complex apps with multiple layers of information while keeping the user interface clean and intuitive.

## What's next for TripMate
Next, we plan to implement persistent local storage so that users’ data is saved between sessions. We also want to allow customizable scales and metrics for energy and activity, add charts and visual summaries of trips, and potentially integrate photo journaling to enrich the travel diary experience.
