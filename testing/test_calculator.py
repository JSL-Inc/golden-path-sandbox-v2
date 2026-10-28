from testing.calculator import add, subtract


def test_add() -> None:
    assert add(2, 3) == 5


def test_subtract() -> None:
    # DEMO ONLY: intentionally wrong expected result for the failure example.
    assert subtract(5, 3) == 3
