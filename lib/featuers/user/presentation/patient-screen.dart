import 'package:flutter/material.dart';
import '../../../data/models/patient_model.dart';
import '../../home/screens/patients/data/model/booking_model.dart';

class PatientScreen extends StatelessWidget {
  final PatientModel patient;

  const PatientScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final bookings = patient.bookings ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete from Firestore
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📞 Phone: ${patient.phone}"),
              const SizedBox(height: 8),
              Text("🎂 Age: ${patient.age}"),
              const SizedBox(height: 8),
              Text("🚻 Gender: ${patient.gender}"),
              const SizedBox(height: 16),

              // --- Appointments Section ---
              const Divider(thickness: 1),
              const Text(
                "Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              bookings.isEmpty
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No bookings found 🗓️",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
                  : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  BookingModel booking = bookings[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text("Date: ${booking.day}"),
                      subtitle: Text("Notes: ${booking.reason ?? "—"}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // TODO: delete booking from Firestore
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Add booking button inside the same screen
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: open add booking form (Dialog or BottomSheet)
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
