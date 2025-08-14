module CollegeApp::TranscriptVerifier {

    use aptos_framework::signer;
    use std::string;

    /// Struct to store transcript data and verification status
    struct Transcript has store, key {
        transcript_hash: string::String,
        is_verified: bool,
    }

    /// Student uploads their transcript hash
    public fun upload_transcript(account: &signer, hash: string::String) {
        assert!(!exists<Transcript>(signer::address_of(account)), 1);
        let data = Transcript {
            transcript_hash: hash,
            is_verified: false,
        };
        move_to(account, data);
    }

    /// College verifies the student's transcript
    public fun verify_transcript(student: address) acquires Transcript {
        let transcript = borrow_global_mut<Transcript>(student);
        transcript.is_verified = true;
    }
}
