from dataclasses import dataclass

def dummy_logger(old):
    old_set_attr = old.__setattr__

    def log_event(self, name, value):
        print(f"Update attribute <{name}> from '{getattr(self, name, None)}' to '{value}'")
        old_set_attr(self, name, value)

    old.__setattr__ = log_event
    return old


@dummy_logger
@dataclass
class Dummy:
    full_name: str = "John Doe"


d = Dummy()
d.full_name = "John Wick"
d.role = "Cleanser"
