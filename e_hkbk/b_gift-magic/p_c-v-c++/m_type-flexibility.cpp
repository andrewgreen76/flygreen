
//...

int main() {
    Shape* shapes[3];
    
    Circle circle;
    Rectangle rectangle;
    Shape shape;
    
    shapes[0] = &circle;
    shapes[1] = &rectangle;
    shapes[2] = &shape;
    
    for (int i = 0; i < 3; ++i) {
        shapes[i]->draw();
    }
    
    return 0;
}

//...

