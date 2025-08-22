package business.user.dto;

public class StaffDTO{
        private int id;             // can hold ID for session

        private String password;    // plain when coming from login form

        public StaffDTO() {}

        public StaffDTO(int id, String password) {
            this.id = id;
            this.password = password;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
}
