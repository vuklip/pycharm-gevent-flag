import os

from locust import run_single_user, FastHttpUser, task, events


@events.init.add_listener
def _(environment, **kw):
    # it needs to throw an error
    environment.user.headers = {"Content-Type": "application/json", "User-Agent": f"{os.path.basename(__file__)}", }


class TestClass(FastHttpUser):
    host = "http://127.0.0.1:8000"
    wait_time = 1

    @task
    def index(self):
        self.client.get("/")


if __name__ == '__main__':
    run_single_user(TestClass)
